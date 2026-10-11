/**
 * Applies <profile>/chrome/zen-live.css to every Zen window as a user sheet,
 * like userChrome.css, and re-applies it whenever it or the local files it
 * @import-s change on disk.
 *
 * This is an experiment API that only uses the "startup" event, so it runs
 * with chrome privileges as soon as Zen starts the extension. Imports are
 * inlined and the result is loaded as a data: URI, so every change is a new
 * sheet the CSS loader hasn't cached. There is no file watcher available to
 * chrome code on Linux, so this polls modification times.
 */

/* global ExtensionAPI, ChromeUtils, IOUtils, PathUtils, Services */

var { clearInterval, setInterval } = ChromeUtils.importESModule(
  "resource://gre/modules/Timer.sys.mjs"
);

var POLL_INTERVAL_MS = 1000;

// `@import url("a.css");`, `@import url(a.css);` or `@import "a.css";`,
// without media queries or layers.
var IMPORT_RE =
  /@import\s+(?:url\(\s*["']?([^"')\s]+)["']?\s*\)|["']([^"']+)["'])\s*;/g;
var URL_SCHEME_RE = /^[a-z][a-z\d+.-]*:/i;

class ZenLive {
  // data: URI of the current stylesheet, null if there is none.
  #uri = null;
  // Window -> the URI loaded into it.
  #applied = new WeakMap();
  // Path -> modification time when last read, null if missing.
  #mtimes = new Map();
  #ready = null;
  #interval = null;
  #polling = false;
  #stopped = false;

  start() {
    Services.obs.addObserver(this, "domwindowopened");
    for (const win of Services.wm.getEnumerator(null)) {
      if (
        win.document.readyState === "loading" ||
        win.document.documentURI === "about:blank"
      ) {
        this.#attachWhenLoaded(win);
      } else {
        this.#attach(win);
      }
    }
  }

  stop() {
    this.#stopped = true;
    Services.obs.removeObserver(this, "domwindowopened");
    if (this.#interval) {
      clearInterval(this.#interval);
    }
    this.#uri = null;
    this.#applyToAll();
  }

  observe(aSubject) {
    this.#attachWhenLoaded(aSubject);
  }

  #attachWhenLoaded(aWindow) {
    const onLoad = event => {
      if (event.target !== aWindow.document) {
        return;
      }
      aWindow.removeEventListener("DOMContentLoaded", onLoad);
      this.#attach(aWindow);
    };
    aWindow.addEventListener("DOMContentLoaded", onLoad);
  }

  async #attach(aWindow) {
    try {
      if (!aWindow.document.documentURI.startsWith("chrome:")) {
        return;
      }
      this.#ready ??= this.#begin();
      await this.#ready;
      if (!this.#stopped) {
        this.#applyTo(aWindow);
      }
    } catch (e) {
      console.error("[ZenLive]:", e);
    }
  }

  async #begin() {
    await this.#read();
    if (!this.#stopped) {
      this.#interval = setInterval(() => this.#poll(), POLL_INTERVAL_MS);
    }
  }

  get #path() {
    return PathUtils.join(PathUtils.profileDir, "chrome", "zen-live.css");
  }

  async #read() {
    const files = new Map();
    const css = await this.#readInlined(this.#path, files);
    this.#mtimes = files;
    this.#uri = css.trim()
      ? "data:text/css;charset=utf-8," + encodeURIComponent(css)
      : null;
  }

  #applyTo(aWindow) {
    const old = this.#applied.get(aWindow) ?? null;
    if (old === this.#uri || aWindow.closed) {
      return;
    }
    const utils = aWindow.windowUtils;
    if (this.#uri) {
      utils.loadSheetUsingURIString(this.#uri, utils.USER_SHEET);
    }
    if (old) {
      utils.removeSheetUsingURIString(old, utils.USER_SHEET);
    }
    this.#applied.set(aWindow, this.#uri);
  }

  #applyToAll() {
    for (const win of Services.wm.getEnumerator(null)) {
      if (this.#applied.has(win)) {
        this.#applyTo(win);
      }
    }
  }

  async #getModifiedTime(aPath) {
    try {
      return (await IOUtils.stat(aPath)).lastModified;
    } catch {
      return null;
    }
  }

  /**
   * Reads a stylesheet with its local @import-s inlined, recording the
   * modification time of every file read in `aFiles`.
   */
  async #readInlined(aPath, aFiles) {
    if (aFiles.has(aPath)) {
      // Already inlined, or an import cycle.
      return "";
    }
    aFiles.set(aPath, await this.#getModifiedTime(aPath));
    let contents;
    try {
      contents = await IOUtils.readUTF8(aPath);
    } catch {
      return "";
    }

    const dir = PathUtils.parent(aPath);
    let result = "";
    let last = 0;
    for (const match of contents.matchAll(IMPORT_RE)) {
      const url = match[1] ?? match[2];
      result += contents.slice(last, match.index);
      last = match.index + match[0].length;
      let importPath = null;
      if (!URL_SCHEME_RE.test(url)) {
        try {
          importPath = PathUtils.joinRelative(dir, url);
        } catch {
          // e.g. a path going up with "..".
        }
      }
      result += importPath
        ? await this.#readInlined(importPath, aFiles)
        : match[0];
    }
    return result + contents.slice(last);
  }

  async #poll() {
    if (this.#polling) {
      return;
    }
    this.#polling = true;
    try {
      for (const [path, mtime] of this.#mtimes) {
        const current = await this.#getModifiedTime(path);
        // A file going missing is most likely an editor's atomic save in
        // progress, so wait for it to come back.
        if (current !== null && current !== mtime) {
          await this.#read();
          if (!this.#stopped) {
            this.#applyToAll();
          }
          break;
        }
      }
    } catch (e) {
      console.error("[ZenLive]: Error reloading zen-live.css:", e);
    } finally {
      this.#polling = false;
    }
  }
}

this.zenLive = class extends ExtensionAPI {
  onStartup() {
    this.live = new ZenLive();
    this.live.start();
  }

  onShutdown() {
    this.live?.stop();
  }

  getAPI() {
    return { zenLive: {} };
  }
};
