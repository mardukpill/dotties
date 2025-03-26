{
  pkgs,
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) enabled;

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
      # wireless.iwd = enabled;
      networkmanager = {
        # wifi = {
        #   backend = "iwd";
        # };
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
