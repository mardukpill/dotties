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

		dms.sddm = {
			enable = true;
			theme = {
				style = "where-is-my-sddm-theme";
				background = "/media/shared/pictures/wallpapers/home.png";
			};
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

	networking = { # TODO: this should be automatically set based upon snowfall var
		hostName = "blade";
	};

	system.stateVersion = "23.05";
}
