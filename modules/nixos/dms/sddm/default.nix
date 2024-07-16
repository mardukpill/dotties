{
	lib,
	namespace,
	config,
	pkgs,
	...
}: let
	inherit (lib) mkIf mkEnableOption mkOption;

	cfg = config.${namespace}.dms.sddm;
in {
	option.${namespace}.dms.sddm = {
		enable = mkEnableOption "sddm";
		theme.style = mkOption {
			type = lib.types.enum [ "where-is-my-sddm-theme" ];
			default = "where-is-my-sddm-theme";
			description = "which sddm theme to use";
		};
		theme.background = mkOption {
			type = lib.types.path;
			default = "";
			description = "Path to the background of the sddm theme.";
		};
	};

	config = mkIf cfg.enable {
		environment.systemPackages = with pkgs; [
			libsForQt5.qt5.qtgraphicaleffects
		];
		services.displayManager = {
			defaultSession = "hyprland"; # FIXME: should be dynamically set
			sddm = {
				enable = true;
				wayland.enable = true;
				theme = "${import ./themes/where-is-my-sddm-theme { inherit pkgs config cfg; }}";
			};
		};
	};
}
