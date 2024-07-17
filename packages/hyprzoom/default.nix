{
  pkgs,
  lib,
  namespace,
  ...
}:
pkgs.writeShellScriptBin "hyprzoom" ''

    if [ "$#" -ne 1 ]; then
    		echo "Usage: $0 {in|out}"
    		exit 1
    fi


    get_zoom_factor() {
    	hyprctl getoption cursor:zoom_factor | grep -oP '\d+(\.\d+)?'
    }

    zoom_step=0.5
    current_zoom=$(get_zoom_factor)

    # Check if the current zoom factor is retrieved successfully
    if [ -z "$current_zoom" ]; then
        echo "Error: Could not retrieve the current zoom factor."
        exit 1
    fi

    # Adjust the zoom factor based on the argument
    if [ "$1" == "in" ]; then
        new_zoom=$(echo "$current_zoom + $zoom_step" | ${pkgs.bc}/bin/bc)
    elif [ "$1" == "out" ]; then
        new_zoom=$(echo "$current_zoom - $zoom_step" | ${pkgs.bc}/bin/bc)
    else
        echo "Usage: $0 {in|out}"
        exit 1
    fi

  	# use bc, due to bash being unable to handle floats
    if (( $(echo "$new_zoom < 1" | ${pkgs.bc}/bin/bc -l) )); then
      new_zoom=1
    fi

  	${pkgs.hyprland}/bin/hyprctl keyword cursor:zoom_factor $new_zoom
''
