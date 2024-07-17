{
	config,
	lib,
	namespace,
	inputs,
	...
}:
let
  inherit (lib.${namespace}) enabled;
in
{
	imports = [
		./boot.nix
		./disks.nix
		./hardware-configuration.nix
	];

	dotties = {
		hw = {
			nvidia = {
				enable = true;
				version = "535";
			};
			razer = enabled;
		};

    apps = {
      thunar = enabled;
    };

		dms.sddm = {
			enable = true;
			theme = {
				style = "where-is-my-sddm-theme";
				background = "/media/shared/pictures/wallpapers/home.png";
			};
		};

    system.nix = {
      managed = true;
      useHelper = true;
    };

		cli = {
			fish = enabled;
		};

		wms = {
			hyprland = enabled;
		};
	};

	nixpkgs = {
		config = {
			allowUnfree = true;
		};
	};

	networking = { 
		hostName = lib.snowfall.system.get-inferred-system-name;
		networkmanager = enabled;
	};



	system.stateVersion = "23.05";
}
