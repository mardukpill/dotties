{
	lib,
	pkgs,
	inputs,
	namespace,
	config,
	...
}: let 
	inherit (lib) mkIf mkOption mkEnableOption enabled;
	spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;

	cfg = config.${namespace}.apps.spotify;
in {
	options.${namespace}.apps.spotify = {
		enable = mkEnableOption "spotify.";
		spicetify = mkOption {
			type = lib.types.bool;
			default = false;
			description = "Whether to enable spicetify ricing for spotify.";
		};
	};

	config = mkIf cfg.enable {
		
		home.packages = mkIf (!cfg.spicetify) [ pkgs.spotify ];

		programs.spicetify = mkIf cfg.spicetify {
			enable = true;
			theme = spicePkgs.themes.text;
			colorScheme = "rosepine";
			enabledExtensions = with spicePkgs.extensions; [
				powerBar
					fullAlbumDate
					history
			];
		};
	};
}

