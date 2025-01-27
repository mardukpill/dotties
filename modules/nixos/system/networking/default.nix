{
  pkgs,
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.system.networking;
in
{
  options.${namespace}.system.networking = {
    enable = mkEnableOption "networking";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      openconnect
      networkmanagerapplet
    ];

    networking = {
      networkmanager = {
        enable = true;
        plugins = with pkgs; [
          networkmanager-openconnect
        ];
      };
    };

    systemd.user.services.nm-applet = {
      description = "nm-applet tray service";
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator";
        Restart = "always";
        RestartSec = 5;
      };
    };

  };
}
