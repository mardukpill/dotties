{
  config,
  lib,
  pkgs,
  namespace,
  inputs,
  ...
}:
let
  inherit (lib) mkIf;

  cfg = config.${namespace}.wms.hyprland;
  externalDisplay = "HDMI-A-1"; # FIXME: this is really dumb
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          "eDP-1,2560x1440@240,0x0,1"
          "${externalDisplay},1920x1080@60,2560x0,1"
        ];

        "debug:disable_logs" = false; # FIXME: remove after debugging

        windowrulev2 = [
          "float,class:float"
          "pin, title:^(Picture-in-Picture)$"
          "float, title:^(Picture-in-Picture)$"

          "workspace 10 silent, class:KeePassXC"
          "workspace 10 silent, class:^(gnome-connections)$"
        ];

        workspace = [
          "10, on-created-empty:keepassxc"
          "11, monitor:${externalDisplay}"
        ];

      };
    };
  };
}
