{
	config,
	lib,
	namespace,
	pkgs,
	...
}: let 
	inherit (lib) mkIf mkEnableOption enabled;

	cfg = config.${namespace}.wms.hyprland;
in {
	options.${namespace}.wms.hyprland = {
		enable = mkEnableOption "hyprland.";
	};

	config = mkIf cfg.enable {
		programs.hyprland.enable = true;
		programs.hyprland.portalPackage = pkgs.xdg-desktop-portal-gtk;

		xdg.portal = {
			enable = true;
			xdgOpenUsePortal = false;
			extraPortals = with pkgs; [
				xdg-desktop-portal-hyprland
				xdg-desktop-portal-gtk
			];
		};
	};
}
