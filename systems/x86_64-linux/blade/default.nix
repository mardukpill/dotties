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
		hw.nvidia = {
			enable = true;
			version = "535";
		};

		system = {
			fonts = enabled;
			manageNix = true;
		};

		wms = {
			hyprland = enabled;
		};
	};

	nix = let
	flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = github:NixOS/nixpkgs/nixos-unstable;
    };
    channel.enable = false;

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

	nixpkgs = {
		config = {
			allowUnfree = true;
		};
	};

	system.stateVersion = "23.05";
}
