{
  namespace,
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption;
  cfg = config.${namespace}.services.xwayland-satellite;
in
{
  options.${namespace}.services.xwayland-satellite = {
    enable = mkEnableOption "xwayland-satellite services.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ xwayland-satellite-unstable ];

    systemd.user.services.xwayland-satellite = {
      Unit = {
        Description = "xwayland-satellite daemon";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        Restart = "always";
        RestartSec = 5;
        ExecStart = "${pkgs.xwayland-satellite-unstable}/bin/xwayland-satellite";
      };
    };
  };
}
