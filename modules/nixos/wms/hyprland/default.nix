{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.wms.hyprland;
in
{
  options.${namespace}.wms.hyprland = {
    enable = mkEnableOption "hyprland.";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      wdisplays
      hyprpaper
    ];

    hardware.brillo = enabled;

    programs.hyprland.enable = true;
    programs.hyprland.withUWSM = true;
    programs.hyprland.portalPackage = pkgs.xdg-desktop-portal-gtk;

    services.displayManager = {
      defaultSession = "hyprland-uwsm";
    };

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
