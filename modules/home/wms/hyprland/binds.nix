{
  config,
  lib,
  pkgs,
  namespace,
  inputs,
  system,
  ...
}:
let
  inherit (lib) mkIf getExe;
  inherit (lib.${namespace}) enabled;
  inherit (inputs) hyprlock;

  cfg = config.${namespace}.wms.hyprland;
in
{
  config = mkIf cfg.enable {
    dotties.utility.anyrun = enabled;

    wayland.windowManager.hyprland = {
      settings = {
        "$mod" = "SUPER";
        "binds:scroll_event_delay" = 1;

        # gestures
        "gestures:workspace_swipe" = true;
        "gestures:workspace_swipe_fingers" = 4;
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        binde = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ", XF86MonBrightnessDown, exec, brillo -U 5 -u 100000"
          ", XF86MonBrightnessUp, exec, brillo -A 5 -u 100000"
        ];

        bindl = [
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"
        ];

        bind =
          [
            # "$mod SHIFT, L, exec, ${getExe hyprlock.packages.${system}.hyprlock} --immediate"
            "$mod CONTROL_SHIFT, X, exec, ${getExe pkgs.wlogout}"
            "$mod,Tab, hyprexpo:expo, toggle"

            # applications
            "$mod, Return, exec, ${pkgs.alacritty}/bin/alacritty"
            "$mod SHIFT, Return, exec, [floating] ${pkgs.alacritty}/bin/alacritty"
            "$mod, E, exec, thunar"
            "$mod SHIFT, E, exec, [floating] thunar"
            "$mod SHIFT, F, exec, ${pkgs.firefox}/bin/firefox"

            # grimblast
            ", Print, exec, grimblast --notify copy area"
            "$mod SHIFT, S, exec, grimblast --notify edit area"
            "$mod CONTROL_SHIFT, S, exec, grimblast --notify edit screen"

            # rofi
            "$mod, D, exec, ${pkgs.anyrun}/bin/anyrun"

            # client controls
            "$mod, M, fullscreen, 1"
            "$mod, F, fullscreen"
            "$mod, Q, killactive,"
            "$mod, G, togglefloating,"
            "$mod, P, pin,"

            # hyprpicker
            "$mod, C, exec, hyprpicker --autocopy --render-inactive"

            # hyprzoom
            "$mod,mouse_down,exec, hyprzoom in"
            "$mod,mouse_up,exec, hyprzoom out"

            # hyprland
            "$mod, left, movefocus, l"
            "$mod, right, movefocus, r"
            "$mod, up, movefocus, u"
            "$mod, down, movefocus, d"
            "$mod, H, movefocus, l"
            "$mod, J, movefocus, d"
            "$mod, K, movefocus, u"
            "$mod, L, movefocus, r"

            "$mod SHIFT, left, movewindow, l"
            "$mod SHIFT, right, movewindow, r"
            "$mod SHIFT, up, movewindow, u"
            "$mod SHIFT, down, movewindow, d"
            "$mod SHIFT, H, movewindow, l"
            "$mod SHIFT, J, movewindow, d"
            "$mod SHIFT, K, movewindow, u"
            "$mod SHIFT, L, movewindow, r"

            "$mod, Space, pseudo,"

            "$mod SHIFT, Z, exec, hyprctl keyword cursor:zoom_factor 1"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
            builtins.concatLists (
              builtins.genList (
                x:
                let
                  ws =
                    let
                      c = (x + 1) / 10;
                    in
                    builtins.toString (x + 1 - (c * 10));
                in
                [
                  "$mod, ${ws}, workspace, ${toString (x + 1)}"
                  "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                  "$mod CTRL, ${ws}, workspace, ${toString ((x + 11))}"
                  "$mod CONTROL_SHIFT, ${ws}, movetoworkspace, ${toString ((x + 11))}"
                ]
              ) 10
            )
          );
      };
    };
  };
}
