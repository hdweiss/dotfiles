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

-- Calendar
hl.unbind("SUPER + SHIFT + C")
o.bind("SUPER + SHIFT + C", "Calendar popup", "omarchy-shell promaa.clock toggle")
o.bind("SUPER + SHIFT + ALT+ C", "Calendar", 'omarchy-launch-webapp "https://calendar.google.com/calendar/u/0/r?pli=1"')

-- WhatsApp  (was: "Signal" / "WhatsApp" webapp)
hl.unbind("SUPER + SHIFT + G")
hl.unbind("SUPER + SHIFT + ALT + G")
o.bind("SUPER + SHIFT + G", "WhatsApp", "omarchy-shell shell toggle io.github.moizibnyousaf.omawhatsapp")
o.bind("SUPER + SHIFT + ALT + G", "WhatsApp (app)", "omarchy-shell io.github.moizibnyousaf.omawhatsapp toggleApp ''")

-- Super Productivity  (replaces the old raw SUPER+SHIFT+T launch)
o.bind("SUPER + SHIFT + T", "Super Productivity", "omarchy-shell shell toggle apsingh.super-productivity")
o.bind("SUPER + SHIFT + ALT + T", "Super Productivity (app)", { launch = "super-productivity", focus = "Productivity" })

-- Obsidian  (was: SUPER+SHIFT+O -> Obsidian desktop; quick search also stays on SUPER+N)
hl.unbind("SUPER + SHIFT + O")
o.bind("SUPER + SHIFT + O", "Obsidian", "omarchy-shell shell toggle io.github.weedwhitesandwine.obsiduous")
o.bind("SUPER + SHIFT + ALT + O", "Obsidian (app)", { launch = "obsidian", focus = "obsidian" })

-- Photos (was: "Google Photos webapp")
hl.unbind("SUPER + SHIFT + P")
o.bind("SUPER + SHIFT + P", "Immich", 'omarchy-launch-webapp "https://photos.weisz.it"')

-- Unused apps
hl.unbind("SUPER + SHIFT + X") -- was X webapp
hl.unbind("SUPER + SHIFT + ALT + X") -- was X webapp
