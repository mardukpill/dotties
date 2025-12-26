{
  lib,
  inputs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (inputs) niri;
  movementBinds = import ./movement.nix { inherit lib config; };

  cfg = config.${namespace}.wms.niri;
in
{
  config = mkIf cfg.enable {

    dotties.apps.rofi = {
      enable = true;
      wayland = true;
    };

    programs.niri.settings = {
      animations = {
        slowdown = 2;
      };

      prefer-no-csd = true;

      input = {
        focus-follows-mouse = {
          enable = false;
        };

      };

      binds =
        with config.lib.niri.actions;
        let
          sh = spawn "sh" "-c";
          Mod = "Mod";
        in
        lib.attrsets.mergeAttrsList [
          {

            # "${Mod}+Tab".action = sh "niri msg action toggle-overview";
            "XF86AudioRaiseVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
            "XF86AudioLowerVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
            "XF86AudioMute".action = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

            "XF86MonBrightnessUp".action = sh "brillo -A 5 -u 10000";
            "XF86MonBrightnessDown".action = sh "brillo -U 5 -u 10000";

            "XF86AudioNext".action = sh "playerctl next";
            "XF86AudioPrev".action = sh "playerctl previous";
            "XF86AudioPlay".action = sh "playerctl play-pause";

            "Mod+Shift+S".action = screenshot;

            "Mod+Q".action = close-window;
            "Mod+S".action = sh "rofi -show window";

            "Mod+D".action.spawn = "anyrun";
            "Mod+Return".action.spawn = "alacritty";
            "Mod+E".action.spawn = "thunar";

            "Mod+Shift+E".action = quit;
            "Mod+Shift+P".action = power-off-monitors;
            "Mod+Shift+Escape".action = toggle-keyboard-shortcuts-inhibit;

            "${Mod}+W".action = sh (
              builtins.concatStringsSep "; " [
                "systemctl --user restart waybar.service"
                "systemctl --user restart razerdaemon.service"

                "swww kill"

                "systemctl --user stop swww-daemon.service"
                # "rm /tmp/razercontrol-socket"
                "systemctl --user start swww-daemon.service"
              ]
            );
          }

          movementBinds
        ];
    };
  };
}
