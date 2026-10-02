-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
-- hl.config({
--   general = {
--     -- No gaps between windows or borders.
--     gaps_in = 0,
--     gaps_out = 0,
--     border_size = 0,
--
--     -- Change to niri-like side-scrolling layout.
--     layout = "scrolling",
--   },
-- })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
-- hl.config({
--   decoration = {
--     -- Use round window corners.
--     rounding = 8,
--
--     -- Dim unfocused windows (0.0 = no dim, 1.0 = fully dimmed).
--     dim_inactive = true,
--     dim_strength = 0.15,
--   },
-- })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#animations
-- hl.config({
--   animations = {
--     -- Disable all animations.
--     enabled = false,
--   },
-- })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#layout
-- hl.config({
--   layout = {
--     -- Avoid overly wide single-window layouts on wide screens.
--     single_window_aspect_ratio = { 1, 1 },
--   },
-- })

-- https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
-- hl.config({
--   scrolling = {
--     -- See only one column per screen instead of two.
--     column_width = 0.97,
--   },
-- })

-- More see-through windows, per theme ("focused unfocused"). Omarchy's default
-- is "0.985 0.96". Skipped when the current theme sets its own opacity (e.g.
-- Kanagawa).
local opacity_by_theme = {
  hackerman = { apps = "0.92 0.87", terminal = "0.88 0.83" },
}
local default_opacity = { apps = "0.97 0.94", terminal = "0.95 0.91" }

local function read_file(path)
  local file = path and io.open(path)
  if not file then
    return nil
  end
  local content = file:read("*a")
  file:close()
  return content
end

local theme_hyprland = read_file(package.searchpath("omarchy.current.theme.hyprland", package.path))
local theme_name = (read_file(os.getenv("HOME") .. "/.local/state/omarchy/current/theme.name") or ""):match("%S+")

if not (theme_hyprland and theme_hyprland:find("opacity")) then
  local opacity = opacity_by_theme[theme_name] or default_opacity
  o.window({ tag = "default-opacity" }, { opacity = opacity.apps })
  o.window({ tag = "terminal" }, { opacity = opacity.terminal })
end
