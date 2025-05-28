{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  lib,
  # An instance of `pkgs` with your overlays and packages applied is also available.
  pkgs,
  # You also have access to your flake's inputs.
  inputs,

  # Additional metadata is provided by Snowfall Lib.
  namespace, # The namespace used for your flake, defaulting to "internal" if not set.
  system, # The system architecture for this host (eg. `x86_64-linux`).
  target, # The Snowfall Lib target for this system (eg. `x86_64-iso`).
  format, # A normalized name for the system target (eg. `iso`).
  virtual, # A boolean to determine whether this system is a virtual target using nixos-generators.
  systems, # An attribute map of your defined hosts.

  # All other arguments come from the module system.
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
      prefer-no-csd = true;
      input = {
        focus-follows-mouse = {
          enable = true;
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
