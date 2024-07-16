{
	pkgs,
	namespace,
	lib,
	inputs,
	config,
	...
}: let 
	inherit (lib) mkIf mkOption;

	cfg = config.${namespace}.system.nix;
in {
	options.${namespace}.system.nix = {
		managed = mkOption {
			type = lib.types.bool;
			default = true;
			description = "whether to manage nix configuration.";
		};
	};

	config = mkIf cfg.managed {
		environment.systemPackages = with pkgs; [
			home-manager
			sqlite
			alejandra
			# TODO: add cachix
		];
		
		nix = let
		flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
		in {
			settings = {
				experimental-features = "nix-command flakes";
				flake-registry = "";
				# Workaround for https://github.com/NixOS/nix/issues/9574
				nix-path = "https://github.com/NixOS/nixpkgs";
			};
			# Opinionated: disable channels
			channel.enable = false;

			# Opinionated: make flake registry and nix path match flake inputs
			registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
			nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

			gc = {
				automatic = true;
				options = "--delete-older-than 7d";
			};
		};
	};
}
