-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")
--
o.bind("SUPER + SHIFT + J", "Jellyfin", 'omarchy-launch-webapp "https://jellyfin.weisz.it"')

-- === App shortcuts: SUPER+SHIFT+<key> = quick widget, +ALT = full app ===

-- Spotify  (was: "Music" spotify desktop / "Music TUI" cliamp)
hl.unbind("SUPER + SHIFT + M")
hl.unbind("SUPER + SHIFT + ALT + M")
o.bind("SUPER + SHIFT + M", "Spotify (mini)", "omarchy-shell quickshell.spotify.player toggleMiniPlayer")
o.bind("SUPER + SHIFT + ALT + M", "Spotify (full)", "omarchy-shell quickshell.spotify.player toggleFullPlayer")

-- Mail  (was: "Email" / "New email" / "Calendar" Hey webapps)
hl.unbind("SUPER + SHIFT + E")
hl.unbind("SUPER + SHIFT + ALT + E")
o.bind("SUPER + SHIFT + E", "Mail", "omarchy-shell shell toggle omamail")
o.bind("SUPER + SHIFT + ALT + E", "Mail (compose)", "omarchy-shell shell summon omamail '{\"compose\":true}'")

-- === App-first: SUPER+SHIFT+<key> = full app, +ALT = quick widget ===

-- Calendar
hl.unbind("SUPER + SHIFT + C")
o.bind("SUPER + SHIFT + C", "Calendar", 'omarchy-launch-webapp "https://calendar.google.com/calendar/u/0/r?pli=1"')
o.bind("SUPER + SHIFT + ALT + C", "Calendar popup", "omarchy-shell promaa.clock toggle")

-- WhatsApp  (was: "Signal" / "WhatsApp" webapp)
hl.unbind("SUPER + SHIFT + G")
hl.unbind("SUPER + SHIFT + ALT + G")
o.bind("SUPER + SHIFT + G", "WhatsApp (app)", "omarchy-shell io.github.moizibnyousaf.omawhatsapp toggleApp ''")
o.bind("SUPER + SHIFT + ALT + G", "WhatsApp", "omarchy-shell shell toggle io.github.moizibnyousaf.omawhatsapp")

-- Super Productivity
o.bind("SUPER + SHIFT + T", "Super Productivity (app)", { launch = "super-productivity", focus = "Productivity" })
o.bind("SUPER + SHIFT + ALT + T", "Super Productivity", "omarchy-shell shell toggle apsingh.super-productivity")

-- Obsidian  (quick search also stays on SUPER+N)
hl.unbind("SUPER + SHIFT + O")
o.bind("SUPER + SHIFT + O", "Obsidian (app)", { launch = "obsidian", focus = "obsidian" })
o.bind("SUPER + SHIFT + ALT + O", "Obsidian", "omarchy-shell shell toggle io.github.weedwhitesandwine.obsiduous")

-- Photos (was: "Google Photos webapp")
hl.unbind("SUPER + SHIFT + P")
o.bind("SUPER + SHIFT + P", "Immich", 'omarchy-launch-webapp "https://photos.weisz.it"')

--  Bitwarden
o.bind("SUPER + CTRL + SLASH", "Bitwarden vault", "omarchy-shell io.github.elevate08.qs-bitwarden-cli toggle")

-- Unused apps
hl.unbind("SUPER + SHIFT + X") -- was X webapp
hl.unbind("SUPER + SHIFT + ALT + X") -- was X webapp


-- Bring Zen to the current workspace (preloaded at login, see autostart.lua)
hl.unbind("SUPER + SHIFT + B")
o.bind("SUPER + SHIFT + B", "Browser", os.getenv("HOME") .. "/.local/bin/zen-summon")
hl.unbind("SUPER + SHIFT + RETURN")
o.bind("SUPER + SHIFT + RETURN", "Browser", os.getenv("HOME") .. "/.local/bin/zen-summon")

-- Super+W hides the last Zen window instead of quitting Zen (see close-or-hide)
hl.unbind("SUPER + W")
o.bind("SUPER + W", "Close window", os.getenv("HOME") .. "/.local/bin/close-or-hide")
