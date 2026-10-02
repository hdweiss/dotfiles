/* Omarchy Theme for Super Productivity */

/*
 * Super Productivity reads this file once per launch, from
 * `app.getPath('userData')/styles.css`, and injects it with
 * webContents.insertCSS(). That path bypasses the in-app theme installer, so
 * none of the installer's restrictions apply -- but it also means a theme
 * switch lands on the app's next start, not immediately.
 *
 * This file deliberately stays inside what the app's own bundled themes do:
 * their selectors, at their specificity, and only the custom properties they
 * set. Reaching past that -- a doubled class to raise specificity, or a
 * property no bundled theme touches -- wins the cascade against the app's own
 * theme picker too, and leaves the user unable to select any other theme.
 *
 * The declarations are written for both mode classes so the Omarchy palette
 * applies whichever way Super Productivity's own dark-mode toggle is set. The
 * palette keys invert on their own for a light theme; the mapping is tuned
 * against the dark ones.
 */

:root {
  --transition-fast: 150ms ease-in-out;
  --transition-normal: 250ms ease-in-out;
}

body.isDarkTheme,
body:not(.isDarkTheme) {
  /* Surfaces, darkest to lightest */
  --sp-bg-darker: {{ darker_background }};
  --sp-bg-dark: {{ dark_background }};
  --sp-bg: {{ background }};
  --sp-bg-raised: {{ mix background selection 30% }};
  --sp-bg-sunken: {{ mix background dark_background 50% }};
  --sp-bg-selected-sub: {{ mix background selection 45% }};
  --sp-surface-alt: {{ lighter_background }};
  --sp-selection: {{ selection }};
  --sp-muted: {{ muted }};
  --sp-surface-high: {{ mix muted foreground 25% }};

  /* Text */
  --sp-fg: {{ foreground }};
  --sp-fg-light: {{ light_foreground }};
  --sp-fg-bright: {{ bright_foreground }};
  --sp-fg-dark: {{ dark_foreground }};

  /* Public theme contract */
  --surface-0: var(--sp-bg-dark);
  --surface-1: var(--sp-bg);
  --surface-2: var(--sp-bg-raised);
  --surface-3: var(--sp-selection);
  --surface-4: var(--sp-muted);

  --ink: rgb({{ foreground_rgb }});
  --ink-strong: var(--sp-fg-bright);
  --ink-muted: var(--sp-fg-dark);
  --ink-on-channel: {{ foreground_rgb }};

  --separator: rgba({{ muted_rgb }}, 0.6);
  --divider: var(--sp-bg-dark);
  --scrim: rgba({{ darker_background_rgb }}, 0.6);

  /* Backgrounds */
  --bg: var(--sp-bg);
  --bg-darker: var(--sp-bg-darker);
  --bg-slightly-lighter: var(--sp-bg-raised);
  --bg-lighter: var(--sp-selection);
  --bg-lightest: var(--sp-muted);
  --bg-super-light: var(--sp-surface-high);
  --bg-overlay: rgba({{ darker_background_rgb }}, 0.6);

  --card-bg: var(--sp-bg-raised);
  --sidenav-bg: var(--sp-bg-dark);
  --selected-task-bg-color: var(--sp-surface-alt);
  --banner-bg: var(--sp-selection);
  --right-panel-bg: var(--sp-bg);
  --bottom-panel-bg: var(--sp-bg-dark);

  --task-c-bg: var(--sp-bg-raised);
  --task-c-selected-bg: var(--sp-selection);
  --task-c-current-bg: var(--sp-surface-alt);
  --task-c-drag-drop-bg: var(--sp-selection);
  --task-c-bg-done: var(--sp-bg-sunken);
  --sub-task-c-bg: var(--sp-bg-raised);
  --sub-task-c-bg-done: var(--sp-bg-sunken);
  --sub-task-c-bg-in-selected: var(--sp-bg-selected-sub);
  --task-detail-bg: var(--sp-bg-raised);
  --task-detail-bg-hover: var(--sp-selection);

  --standard-note-bg: var(--sp-bg-raised);
  --standard-note-bg-hovered: var(--sp-selection);

  --planner-task-bg: var(--sp-bg-dark);
  --planner-days-bg: var(--sp-bg-darker);
  --schedule-event-bg: var(--sp-bg-raised);

  --code-bg: var(--sp-bg-sunken);
  --code-fg: {{ bright_cyan }};

  --input-bg: rgba({{ foreground_rgb }}, 0.06);
  --input-bg-hover: rgba({{ foreground_rgb }}, 0.1);
  --input-border-color: rgba({{ muted_rgb }}, 0.5);

  --sidenav-hover-bg: rgba({{ foreground_rgb }}, 0.06);
  --sidenav-item-active-bg: rgba({{ accent_rgb }}, 0.18);

  /*
   * The app derives a few surfaces from a fixed neutral-grey ramp it declares
   * on `:root`, and redeclares the derived names on `body.isDarkTheme` -- the
   * same specificity this file uses, but later in the document, so a plain
   * declaration here loses the tie and sub-task rows stay grey. Setting the
   * greys instead wins on specificity alone, `:root` being weaker than
   * `body.isDarkTheme`, with no dependence on document order.
   *
   * Only the three greys whose every consumer is set by all fifteen bundled
   * themes are touched. A selected theme therefore always overrides the
   * derived value and never sees these, which is what keeps the app's own
   * theme picker working. The rest of the ramp is deliberately left alone:
   * each has at least one consumer some bundled theme does not set, and would
   * show this palette through that theme.
   */
  --dark2: var(--sp-bg-sunken); /* -> --sub-task-c-bg-done */
  --dark3: var(--sp-bg-raised); /* -> --surface-2 */
  --dark4-5: var(--sp-bg-raised); /* -> --sub-task-c-bg */

  /* Text colors */
  --text-color: var(--sp-fg);
  --text-color-less-intense: rgba({{ foreground_rgb }}, 0.87);
  --text-color-muted: var(--sp-fg-dark);
  --text-color-more-intense: var(--sp-fg-light);
  --text-color-most-intense: var(--sp-fg-bright);

  --standard-note-fg: var(--sp-fg);
  --task-detail-value-color: rgba({{ foreground_rgb }}, 0.7);

  /* Borders and separators */
  --extra-border-color: var(--sp-bg-darker);
  --separator-color: rgba({{ muted_rgb }}, 0.6);
  --divider-color: var(--sp-bg-dark);
  --chip-outline-color: rgba({{ foreground_rgb }}, 0.23);

  /*
   * Material's accent ramp. The template's own mix helper can only blend two
   * palette keys, and there is no white or black among them, so the tints and
   * shades are mixed in CSS instead -- the same way the app's own cybr and
   * liquid-glass themes build theirs.
   */
  --c-accent: {{ accent }};
  --palette-accent-500: {{ accent }};
  --palette-accent-100: color-mix(in srgb, {{ accent }} 25%, #ffffff);
  --palette-accent-200: color-mix(in srgb, {{ accent }} 45%, #ffffff);
  --palette-accent-300: color-mix(in srgb, {{ accent }} 65%, #ffffff);
  --palette-accent-400: color-mix(in srgb, {{ accent }} 85%, #ffffff);
  --palette-accent-600: color-mix(in srgb, {{ accent }} 88%, #000000);
  --palette-accent-700: color-mix(in srgb, {{ accent }} 75%, #000000);
  --palette-accent-800: color-mix(in srgb, {{ accent }} 60%, #000000);
  --palette-accent-900: color-mix(in srgb, {{ accent }} 45%, #000000);
  --palette-accent-contrast-500: var(--sp-bg);

  /*
   * The brand channel, which is separate from the accent ramp and otherwise
   * follows the current work context's own colour. It tints links, the active
   * sidenav item and the focus ring.
   */
  --brand: {{ accent }};
  --focus-ring: {{ accent }};

  /*
   * `yellow` is a green in some palettes (Osaka Jade), which would make a
   * warning indistinguishable from a success. `bright_yellow` is a yellow or
   * orange in every stock theme.
   */
  --c-success: {{ green }};
  --c-warning: {{ bright_yellow }};
  --c-error: {{ red }};
  --c-info: {{ blue }};
  --color-success: {{ green }};
  --color-warning: {{ bright_yellow }};
  --color-danger: {{ red }};

  /* UI elements */
  --scrollbar-thumb: var(--sp-selection);
  --scrollbar-thumb-hover: var(--sp-muted);
  --scrollbar-track: var(--sp-bg);

  --close-btn-bg: var(--sp-selection);
  --close-btn-border: transparent;

  --select-hover-bg: rgba({{ foreground_rgb }}, 0.12);
  --options-border-color: rgba({{ foreground_rgb }}, 0.2);

  --attachment-bg: var(--sp-bg-raised);
  --attachment-border: transparent;
  --attachment-control-bg: rgba({{ darker_background_rgb }}, 0.5);
  --attachment-control-border: transparent;
  --attachment-control-hover-bg: rgba({{ darker_background_rgb }}, 0.8);

  --grid-color: rgba({{ foreground_rgb }}, 0.08);
  --progress-bg: rgba({{ foreground_rgb }}, 0.15);

  --improvement-text: var(--sp-fg);
  --improvement-border: rgba({{ foreground_rgb }}, 0.3);
  --improvement-button-text: var(--sp-bg);

  --color-background-color-options: var(--sp-bg-selected-sub);
  --color-background-text-field: rgba({{ foreground_rgb }}, 0.1);
  --color-background-dark: var(--sp-bg-darker);
  --color-background-notes: var(--sp-bg-raised);
  --color-background-inline-markdown: var(--sp-bg-sunken);
  --color-background-button-shadow: {{ accent }};

  /* Shadows */
  --shadow-key-umbra-opacity: 0.15;
  --shadow-key-penumbra-opacity: 0.1;
  --shadow-ambient-shadow-opacity: 0.08;

  --task-current-shadow: 0 2px 6px rgba({{ darker_background_rgb }}, 0.45);
  --task-selected-shadow: 0 1px 3px rgba({{ darker_background_rgb }}, 0.35);

  /* Interaction states */
  --hover-controls-border: 1px solid rgba({{ foreground_rgb }}, 0.3);
  --hover-controls-border-opacity: 0.3;

  --hover-bg-opacity: 0.04;
  --focus-bg-opacity: 0.08;
  --pressed-bg-opacity: 0.12;
  --disabled-opacity: 0.38;
}

/*
 * The rest of that grey ramp, which paints the task detail panel and its
 * setting boxes (`.input-item`, `.mat-expansion-panel` -> --task-detail-bg ->
 * --dark8) among others. Each of these has at least one consumer some bundled
 * theme leaves unset, so setting them unconditionally would show this palette
 * through that theme.
 *
 * Instead they are scoped to "no other theme is applied". Super Productivity
 * gives the stylesheet of the active built-in or user theme the id
 * `custom-theme-stylesheet` and removes that element when the theme is
 * Default, so this block matches only while the app is on Default -- the one
 * case where these greys are what would otherwise show. :has() is live, so
 * selecting a theme stops it matching straight away.
 *
 * Where one grey feeds two of our surfaces the more visible role wins; the
 * pairs sit within a few units of each other either way.
 */
html:not(:has(#custom-theme-stylesheet)) body.isDarkTheme {
  --dark0: var(--sp-bg-dark); /* -> --surface-0 */
  --dark1: var(--sp-bg-sunken); /* -> --task-c-bg-done, --bottom-panel-bg */
  --dark4: var(--sp-bg-raised); /* -> --bg-slightly-lighter */
  --dark6: var(--sp-selection); /* -> --task-c-selected-bg, --selected-task-bg-color */
  --dark8: var(--sp-bg-raised); /* -> --task-detail-bg */
  --dark10: var(--sp-bg-selected-sub); /* -> --sub-task-c-bg-in-selected, --standard-note-bg */
  --dark12: var(--sp-selection); /* -> --surface-3, --task-detail-bg-hover */
  --dark16: var(--sp-selection);
  --dark24: var(--sp-muted); /* -> --surface-4, --standard-note-bg-hovered */
}

/*
 * Angular Material's own component tokens, which the app hardcodes to grey 800
 * on a bare `.isDarkTheme` and which no bundled theme touches at all. They are
 * every surface that floats above the page: dialogs (schedule task, links &
 * files), menus, the datepicker behind a deadline, expansion panels and cards
 * in the settings plugin list, select panels, tables.
 *
 * `.isDarkTheme` is one class, so `body.isDarkTheme` already outranks it and
 * no guard is needed on specificity grounds -- but a bundled theme cannot
 * override what it never declares, so setting these unconditionally would
 * repaint every other theme's dialogs in this palette. Hence the same
 * "Default theme only" scope as the block above.
 *
 * Text and divider alphas are left as they are: white at low alpha reads
 * correctly on any dark surface. The tooltip and snack bar keep Material's
 * light container with dark text, which is a matched pair and breaks if only
 * one half is repainted.
 */
html:not(:has(#custom-theme-stylesheet)) body.isDarkTheme {
  /* The page itself */
  --mat-app-background-color: var(--sp-bg);
  --mat-sidenav-content-background-color: var(--sp-bg);
  --mat-sidenav-container-background-color: var(--sp-bg-dark);
  --mat-toolbar-container-background-color: var(--sp-bg-dark);

  /* Surfaces that float above it */
  --mat-dialog-container-color: var(--sp-bg-raised);
  --mat-menu-container-color: var(--sp-bg-raised);
  --mat-autocomplete-background-color: var(--sp-bg-raised);
  --mat-select-panel-background-color: var(--sp-bg-raised);
  --mat-bottom-sheet-container-background-color: var(--sp-bg-raised);
  --mat-datepicker-calendar-container-background-color: var(--sp-bg-raised);
  --mat-timepicker-container-background-color: var(--sp-bg-raised);
  --mat-expansion-container-background-color: var(--sp-bg-raised);
  --mat-card-elevated-container-color: var(--sp-bg-raised);
  --mat-card-filled-container-color: var(--sp-bg-raised);
  --mat-card-outlined-container-color: var(--sp-bg-raised);
  --mat-stepper-container-color: var(--sp-bg-raised);
  --mat-table-background-color: var(--sp-bg-raised);
  --mat-tree-container-background-color: var(--sp-bg-raised);
  --mat-paginator-container-background-color: var(--sp-bg-raised);

  /* Controls */
  --mat-button-filled-container-color: var(--sp-selection);
  --mat-button-protected-container-color: var(--sp-selection);
  --mat-button-tonal-container-color: var(--sp-selection);
  --mat-button-toggle-background-color: var(--sp-bg-raised);
  --mat-button-toggle-disabled-state-background-color: var(--sp-bg-sunken);
  --mat-button-toggle-legacy-disabled-state-background-color: var(--sp-bg-sunken);
  --mat-fab-container-color: var(--c-accent);
  --mat-form-field-filled-container-color: var(--sp-selection);
  --mat-slide-toggle-handle-surface-color: var(--sp-surface-high);

  /* Dividers and outlines */
  --mat-divider-color: var(--separator);
  --mat-menu-divider-color: var(--separator);
  --mat-expansion-actions-divider-color: var(--separator);
  --mat-datepicker-calendar-header-divider-color: var(--separator);
  --mat-sidenav-container-divider-color: var(--separator);
  --mat-stepper-line-color: var(--separator);
  --mat-table-row-item-outline-color: var(--separator);
  --mat-card-outlined-outline-color: var(--separator);
  --mat-button-toggle-divider-color: var(--separator);
}

/*
 * The dark theme lays a gradient tinted with the current work context's colour
 * over the whole page, which drags every neutral surface toward that hue --
 * grey sub-task rows read as brown under a warm one. Six of the app's own
 * bundled themes drop it exactly like this so their palette is what shows.
 */
body::before,
body .first-line:hover .hover-controls::before {
  display: none !important;
}

/* Base surface */
body,
body.isDarkTheme,
body:not(.isDarkTheme) {
  background-color: var(--bg);
  color: var(--text-color) !important;
  transition:
    background-color var(--transition-normal),
    color var(--transition-normal);
}

body .page-wrapper,
body.isDarkTheme .page-wrapper,
body:not(.isDarkTheme) .page-wrapper {
  color: var(--text-color) !important;
}

/* Links */
a,
body a[href],
body.isDarkTheme a[href],
body:not(.isDarkTheme) a[href] {
  color: {{ blue }};
  text-decoration: none;
  transition: opacity var(--transition-fast);
}

a:hover,
body a[href]:hover,
body.isDarkTheme a[href]:hover,
body:not(.isDarkTheme) a[href]:hover {
  opacity: 0.8;
}

/* Hover state, scoped to the row under the pointer */
@media (hover: hover) {
  body
    task:not(.isSelected):not(.isCurrent):hover:not(:has(task:hover))
    > swipe-block
    > .inner-wrapper
    > .box {
    background-color: var(--task-c-selected-bg);
    transition: background-color var(--transition-fast);
  }
}

*:focus-visible {
  outline: 2px solid var(--c-accent);
  outline-offset: 2px;
}

/* Material overrides */
body.isDarkTheme,
body:not(.isDarkTheme) {
  --mat-theme-surface: var(--card-bg);
  --mat-theme-on-surface: var(--text-color);
  --mat-theme-background: var(--bg);
  --mat-theme-primary: var(--c-accent);
  --mat-fab-small-container-color: var(--c-accent);
  --mat-sys-primary-container: var(--c-accent);
}

/* Code */
code,
pre {
  background-color: var(--code-bg);
  color: var(--code-fg);
  border-radius: 4px;
  padding: 2px 4px;
}
