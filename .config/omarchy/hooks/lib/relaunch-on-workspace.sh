# Sourced by the theme-set hooks that restart an app, so the app comes back on
# the workspace it was on instead of the active one, without taking focus.
# omarchy-hook only runs files named after a hook, so this file is never run on
# its own.
#
# Usage:
#   ws=$(window_workspace <class>)           # before killing the app
#   relaunch_on_workspace <class> "$ws" <command> [args...]
#
# Classes are compared lowercased with dashes dropped, so "superproductivity"
# matches superProductivity and super-productivity alike.

window_workspace() {
  hyprctl clients -j 2>/dev/null | jq -r --arg c "$1" '
    first(.[] | select(.class | ascii_downcase | gsub("-"; "") == $c) | .workspace.name) // empty'
}

active_workspace() {
  hyprctl activeworkspace -j 2>/dev/null | jq -r '.name // empty'
}

# Go back to the window that had focus before the relaunch, or failing that
# (it closed, or the workspace was empty), to its workspace.
restore_focus() {
  local window="$1" workspace="$2"

  if [[ -n $window ]] && hyprctl dispatch "hl.dsp.focus({ window = \"address:$window\" })" | grep -qx ok; then
    return
  fi
  hyprctl dispatch "hl.dsp.focus({ workspace = \"$workspace\" })" >/dev/null
}

# The app opens on the active workspace and is moved once its window appears.
# Keep watching a few seconds past the first window, so a browser restoring
# several windows gets all of them moved. While watching, undo any focus the
# app pulls to its workspace -- a new window takes focus, and apps often
# activate themselves once loaded -- but leave a workspace switch elsewhere
# alone, since that is the user moving on.
move_new_windows_to() {
  local class="$1" workspace="$2" focus_window="$3" focus_workspace="$4"
  local address seen=" " first_seen=""

  for i in {1..60}; do
    for address in $(hyprctl clients -j 2>/dev/null | jq -r --arg c "$class" '
      .[] | select(.class | ascii_downcase | gsub("-"; "") == $c) | .address'); do
      [[ $seen == *" $address "* ]] && continue
      seen+="$address "
      first_seen=${first_seen:-$i}
      hyprctl dispatch "hl.dsp.window.move({ workspace = \"$workspace\", follow = false, window = \"address:$address\" })" >/dev/null
    done

    if [[ -n $first_seen && $focus_workspace != "$workspace" && $(active_workspace) == "$workspace" ]]; then
      restore_focus "$focus_window" "$focus_workspace"
    fi

    [[ -n $first_seen ]] && (( i - first_seen >= 6 )) && break
    sleep 0.5
  done
}

relaunch_on_workspace() {
  local class="$1" workspace="$2" focus_window focus_workspace
  shift 2

  focus_window=$(hyprctl activewindow -j 2>/dev/null | jq -r '.address // empty')
  focus_workspace=$(active_workspace)

  setsid uwsm-app -- "$@" >/dev/null 2>&1 &

  # Detached, so the hook (and theme switch) doesn't wait on the window.
  if [[ -n $workspace ]]; then
    export -f move_new_windows_to restore_focus active_workspace
    setsid bash -c 'move_new_windows_to "$@"' _ "$class" "$workspace" "$focus_window" "$focus_workspace" >/dev/null 2>&1 &
  fi
}
