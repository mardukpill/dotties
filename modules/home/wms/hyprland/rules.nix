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
  primaryDisplay = "eDP-1";
  secondaryDisplay = "DP-4";
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        # window swallowing
        "misc:enable_swallow" = true;
        "misc:swallow_regex" = "^(Alacritty)$";
        "misc:swallow_exception_regex" = "^(wev)$";

        # disable anime girl
        "misc:force_default_wallpaper" = 0;

        exec-once = [
          "uwsm finalize"
        ];

        monitor = [
          "${primaryDisplay},2560x1440@240,0x0,1"
          "${secondaryDisplay},1920x1080@60,2560x0,1"
        ];

        "debug:disable_logs" = false;
        general = {
          allow_tearing = true;
        };

        windowrulev2 = [
          "float,class:float"
          "pin, title:^(Picture-in-Picture)$"
          "float, title:^(Picture-in-Picture)$"
          "float, class:^(floating)$"

          "workspace 10 silent, class:^(KeePassXC)$"
          "workspace 10 silent, class:^(gnome-connections)$"
          "immediate class:^(cs2)$"
        ];

        workspace = builtins.concatLists [
          [ "10, on-created-empty:keepassxc" ]
          (
            # assign workspaces 1-10 to primaryDisplay
            builtins.genList (
              x:
              let
                ws = builtins.toString (x + 1);
              in
              "${ws}, monitor:${primaryDisplay}"
            ) 10
          )
          # assign workspaces 11-20 to externalDisplay
          (builtins.genList (
            x:
            let
              ws = builtins.toString (x + 10);
            in
            "${ws}, monitor:${secondaryDisplay}"
          ) 10)
        ];
      };
    };
  };
}
