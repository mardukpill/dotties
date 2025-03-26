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

  cfg = config.${namespace}.wms.niri;
in
{
  options.${namespace}.wms.niri = {
    enable = mkEnableOption "niri.";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      wdisplays
    ];

    hardware.brillo = enabled;

    programs.niri.enable = true;

    services.displayManager = {
      defaultSession = "niri";
    };

    dotties = {
      system.security.polkit = enabled;
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = false;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
      ];
    };
  };
}
