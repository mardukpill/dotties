{
  namespace,
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkOption mkEnableOption;
  cfg = config.${namespace}.services.swww;
in
{
  options.${namespace}.services.swww = {
    enable = mkEnableOption "swww services.";
    wallpaperPath = mkOption {
      type = lib.types.path;
      default = "";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ swww ];

    systemd.user.services.swww-daemon = {
      Unit = {
        Description = "swww daemon";
      };
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
      Service = {
        Restart = "always";
        RestartSec = 5;
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
      };
    };

    # TODO: make script to rotate through folder of wallpapers
    systemd.user.services.swww-paper = mkIf (cfg.wallpaperPath != "") {
      Unit = {
        Description = "setting swww wallpaper";
      };
      Install = {
        WantedBy = [ "swww-daemon.service" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.swww}/bin/swww img ${cfg.wallpaperPath}";
      };
    };
  };
}
