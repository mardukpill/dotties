{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption types;
  inherit (lib.${namespace}) mkOpt;

  cfg = config.${namespace}.wms.aerospace;
in
{
  options.${namespace}.wms.aerospace = {
    enable = mkEnableOption "aerospace window manager";

    settings = mkOpt types.attrs { } "Additional aerospace settings to merge";
  };

  config = mkIf (cfg.enable && pkgs.stdenv.isDarwin) {

    system.defaults = {
      spaces.spans-displays = true;
    };

    services.aerospace = {
      enable = true;
      settings = lib.mkMerge [
        {
          after-startup-command = [ "layout tiles" ];
          on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];

          enable-normalization-flatten-containers = true;
          enable-normalization-opposite-orientation-for-nested-containers = false;

          accordion-padding = 30;
          default-root-container-layout = "tiles";
          default-root-container-orientation = "auto";

          on-window-detected = [
            {
              "if".app-id = "com.apple.FaceTime";
              run = "layout floating";
            }
            {
              "if".app-id = "org.keepassxc.KeePassXC";
              run = [ "move-node-to-workspace 10" ];
            }
            {
              "if".app-id = "com.apple.ScreenSharing";
              run = "layout floating";
            }
          ];

          mode.main.binding = {
            cmd-h = [ ];
            cmd-alt-h = [ ];

            alt-enter = ''exec-and-forget ${pkgs.alacritty}/bin/alacritty'';
            alt-e = ''exec-and-forget open -a Finder'';
            alt-shift-f = ''exec-and-forget ${pkgs.firefox}/bin/firefox'';
            alt-d = ''exec-and-forget open -a Raycast'';

            alt-q = "close";
            alt-f = "fullscreen";
            alt-g = "layout floating tiling";
            alt-m = "fullscreen";

            alt-v = "layout horizontal vertical";
            alt-slash = "layout tiles";
            alt-period = "layout accordion";
            alt-space = "layout tiles accordion";
            alt-b = "balance-sizes";

            alt-h = "focus --boundaries all-monitors-outer-frame left";
            alt-j = "focus --boundaries all-monitors-outer-frame down";
            alt-k = "focus --boundaries all-monitors-outer-frame up";
            alt-l = "focus --boundaries all-monitors-outer-frame right";

            alt-left = "focus --boundaries all-monitors-outer-frame left";
            alt-down = "focus --boundaries all-monitors-outer-frame down";
            alt-up = "focus --boundaries all-monitors-outer-frame up";
            alt-right = "focus --boundaries all-monitors-outer-frame right";

            alt-shift-h = "move left";
            alt-shift-j = "move down";
            alt-shift-k = "move up";
            alt-shift-l = "move right";

            alt-shift-left = "move left";
            alt-shift-down = "move down";
            alt-shift-up = "move up";
            alt-shift-right = "move right";

            alt-shift-minus = "resize smart -50";
            alt-shift-equal = "resize smart +50";

            alt-1 = "workspace 1";
            alt-2 = "workspace 2";
            alt-3 = "workspace 3";
            alt-4 = "workspace 4";
            alt-5 = "workspace 5";
            alt-6 = "workspace 6";
            alt-7 = "workspace 7";
            alt-8 = "workspace 8";
            alt-9 = "workspace 9";
            alt-0 = "workspace 10";

            alt-shift-1 = "move-node-to-workspace 1";
            alt-shift-2 = "move-node-to-workspace 2";
            alt-shift-3 = "move-node-to-workspace 3";
            alt-shift-4 = "move-node-to-workspace 4";
            alt-shift-5 = "move-node-to-workspace 5";
            alt-shift-6 = "move-node-to-workspace 6";
            alt-shift-7 = "move-node-to-workspace 7";
            alt-shift-8 = "move-node-to-workspace 8";
            alt-shift-9 = "move-node-to-workspace 9";
            alt-shift-0 = "move-node-to-workspace 10";

            alt-ctrl-1 = "workspace 11";
            alt-ctrl-2 = "workspace 12";
            alt-ctrl-3 = "workspace 13";
            alt-ctrl-4 = "workspace 14";
            alt-ctrl-5 = "workspace 15";
            alt-ctrl-6 = "workspace 16";
            alt-ctrl-7 = "workspace 17";
            alt-ctrl-8 = "workspace 18";
            alt-ctrl-9 = "workspace 19";
            alt-ctrl-0 = "workspace 20";

            alt-ctrl-shift-1 = "move-node-to-workspace 11";
            alt-ctrl-shift-2 = "move-node-to-workspace 12";
            alt-ctrl-shift-3 = "move-node-to-workspace 13";
            alt-ctrl-shift-4 = "move-node-to-workspace 14";
            alt-ctrl-shift-5 = "move-node-to-workspace 15";
            alt-ctrl-shift-6 = "move-node-to-workspace 16";
            alt-ctrl-shift-7 = "move-node-to-workspace 17";
            alt-ctrl-shift-8 = "move-node-to-workspace 18";
            alt-ctrl-shift-9 = "move-node-to-workspace 19";
            alt-ctrl-shift-0 = "move-node-to-workspace 20";

            alt-shift-ctrl-h = "focus-monitor left";
            alt-shift-ctrl-j = "focus-monitor down";
            alt-shift-ctrl-k = "focus-monitor up";
            alt-shift-ctrl-l = "focus-monitor right";

            alt-u = "workspace-back-and-forth";
            alt-tab = "workspace-back-and-forth";
            alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

            alt-shift-w = "mode service";

            alt-shift-s = "exec-and-forget screencapture -i -c";
            alt-ctrl-shift-s = "exec-and-forget screencapture -c";
          };

          mode.service.binding = {
            alt-shift-w = "mode main";

            alt-shift-h = [
              "join-with left"
              "mode main"
            ];
            alt-shift-j = [
              "join-with down"
              "mode main"
            ];
            alt-shift-k = [
              "join-with up"
              "mode main"
            ];
            alt-shift-l = [
              "join-with right"
              "mode main"
            ];

            alt-shift-left = [
              "join-with left"
              "mode main"
            ];
            alt-shift-down = [
              "join-with down"
              "mode main"
            ];
            alt-shift-up = [
              "join-with up"
              "mode main"
            ];
            alt-shift-right = [
              "join-with right"
              "mode main"
            ];

            esc = "mode main";
          };
        }
        cfg.settings
      ];
    };
  };
}
