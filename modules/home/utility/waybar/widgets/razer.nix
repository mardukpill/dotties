{ pkgs }: let
	script = pkgs.writeShellScriptBin "razer-bar" ''
		status=$(cat /sys/class/power_supply/BAT0/status)
		
		if [ "$status" == "Not charging" ] 
			echo "󱊡"
		else
			power_mode=$(razer-cli read power ac | tail -n1 | cut -d' ' -f4)
			if [ "$power_mode" == "Balanced" ]
				echo "󱎖" # 
			else
				echo "󰽢"
			fi
		fi
	''; 
in {
  programs.waybar.settings.mainBar = {
    "custom/razer" = {
			exec = "${script}/bin/razer-bar";
      format = "{}";
    };
  };
}
