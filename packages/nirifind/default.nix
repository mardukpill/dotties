{
  pkgs,
  lib,
  namespace,
  ...
}:
pkgs.writeShellScriptBin "nirifind" ''
  error_exit() {
    echo "Error: $1" >&2
    exit 1
  }
  # Get the window list from niri
  window_output=$(niri msg windows) || error_exit "Failed to get window list from niri"
  # Initialize arrays and variables
  declare -a window_entries
  current_id=""
  current_title=""
  current_app_id=""
  current_ws=""
  current_pid=""
  is_focused=false
  # Process the window output
  while IFS= read -r line; do
    # Window ID and focused status
    if [[ $line =~ ^Window\ ID\ ([0-9]+): ]]; then
      # Process previous window if exists
      if [ "$current_id" != "" ]; then
        focus_indicator=""
        if "$is_focused"; then
          focus_indicator="*"
        fi
        window_entries+=("$focus_indicator [W:$current_ws] $current_app_id [$current_id] - $current_title")
      fi
      # Reset for new window
      current_id="''${BASH_REMATCH[1]}"
      is_focused=false
      if [[ $line =~ \(focused\) ]]; then
        is_focused=true
      fi
    # Window title
    elif [[ $line =~ ^\ \ Title:\ \"(.*)\" ]]; then
      current_title="''${BASH_REMATCH[1]}"
    # App ID
    elif [[ $line =~ ^\ \ App\ ID:\ \"(.*)\" ]]; then
      current_app_id="''${BASH_REMATCH[1]}"
    # PID
    elif [[ $line =~ ^\ \ PID:\ ([0-9]+) ]]; then
      current_pid="''${BASH_REMATCH[1]}"
    # Workspace ID
    elif [[ $line =~ ^\ \ Workspace\ ID:\ ([0-9]+) ]]; then
      current_ws="''${BASH_REMATCH[1]}"
    fi
  done <<<"$window_output"
  # Process the last window
  if [ "$current_id" != "" ]; then
    focus_indicator=""
    if "$is_focused"; then
      focus_indicator="*"
    fi
    window_entries+=("$focus_indicator [W:$current_ws] $current_app_id [$current_id] - $current_title")
  fi
  # Check if we have any windows
  if [ ''${#window_entries[@]} -eq 0 ]; then
    error_exit "No windows found"
  fi
  # Sort by workspace
  IFS=$'\n'
  sorted_entries=($(for entry in "''${window_entries[@]}"; do
    echo "$entry"
  done | sort -t ':' -k1.4,1n))
  unset IFS
  # Display the window list with wofi
  selected=$(printf "%s\n" "''${sorted_entries[@]}" | wofi --show dmenu -i -p "Search Windows:") || exit 0
  # Extract the window ID from the selection
  if [ "$selected" != "" ]; then
    if [[ $selected =~ \[([0-9]+)\] ]]; then
      window_id="''${BASH_REMATCH[1]}"
      niri msg action focus-window --id "$window_id" || error_exit "Failed to focus window ID $window_id"
    else
      error_exit "Failed to extract window ID from selection"
    fi
  fi
''
