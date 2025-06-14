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

  config = mkIf cfg.enable {
    # Set macOS defaults for aerospace compatibility
    system.defaults = {
      # Displays have separate spaces is required for aerospace to work properly
      spaces.spans-displays = true;
      # Group windows by application in Mission Control
      dock.expose-group-apps = true;
    };

    # Main aerospace service configuration
    services.aerospace = {
      enable = true;
      settings = lib.mkMerge [
        {
          # Basic settings
          after-startup-command = [ "layout tiles" ];
          on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];

          enable-normalization-flatten-containers = true;
          enable-normalization-opposite-orientation-for-nested-containers = false;

          accordion-padding = 30;
          default-root-container-layout = "tiles";
          default-root-container-orientation = "auto";

          # Window detection rules
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

          # Main mode keybindings (based on your Hyprland config)
          mode.main.binding = {
            # Disable macOS hide app shortcuts
            cmd-h = [ ];
            cmd-alt-h = [ ];

            # Application launching
            alt-enter = ''exec-and-forget ${pkgs.alacritty}/bin/alacritty'';
            alt-shift-enter = [
              ''exec-and-forget ${pkgs.alacritty}/bin/alacritty''
              "layout floating"
            ];
            alt-e = ''exec-and-forget open -a Finder'';
            alt-shift-f = ''exec-and-forget ${pkgs.firefox}/bin/firefox'';
            alt-d = ''exec-and-forget open -a Raycast''; # Using Raycast as anyrun alternative

            # Window management
            alt-q = "close";
            alt-f = "fullscreen";
            alt-g = "layout floating tiling"; # Toggle floating
            alt-m = "fullscreen"; # Fullscreen (like your "fullscreen, 1")

            # Layout management
            alt-v = "layout horizontal vertical";
            alt-slash = "layout tiles";
            alt-period = "layout accordion";
            alt-space = "layout tiles accordion"; # Toggle between layouts
            alt-b = "balance-sizes";

            # Focus movement (hjkl)
            alt-h = "focus --boundaries all-monitors-outer-frame left";
            alt-j = "focus --boundaries all-monitors-outer-frame down";
            alt-k = "focus --boundaries all-monitors-outer-frame up";
            alt-l = "focus --boundaries all-monitors-outer-frame right";

            # Focus movement (arrows)
            alt-left = "focus --boundaries all-monitors-outer-frame left";
            alt-down = "focus --boundaries all-monitors-outer-frame down";
            alt-up = "focus --boundaries all-monitors-outer-frame up";
            alt-right = "focus --boundaries all-monitors-outer-frame right";

            # Window movement (hjkl)
            alt-shift-h = "move left";
            alt-shift-j = "move down";
            alt-shift-k = "move up";
            alt-shift-l = "move right";

            # Window movement (arrows)
            alt-shift-left = "move left";
            alt-shift-down = "move down";
            alt-shift-up = "move up";
            alt-shift-right = "move right";

            # Resize
            alt-shift-minus = "resize smart -50";
            alt-shift-equal = "resize smart +50";

            # Workspace switching (1-10)
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

            # Move window to workspace (1-10)
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

            # Additional workspaces (11-20) with ctrl modifier
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

            # Move to additional workspaces
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

            # Monitor focus
            alt-shift-ctrl-h = "focus-monitor left";
            alt-shift-ctrl-j = "focus-monitor down";
            alt-shift-ctrl-k = "focus-monitor up";
            alt-shift-ctrl-l = "focus-monitor right";

            # Workspace navigation
            alt-u = "workspace-back-and-forth";
            alt-tab = "workspace-back-and-forth";
            alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

            # Enter service mode
            alt-shift-w = "mode service";

            # Screenshot equivalent (using macOS shortcuts)
            alt-shift-s = "exec-and-forget screencapture -i -c";
            alt-ctrl-shift-s = "exec-and-forget screencapture -c";
          };

          # Service mode for window operations
          mode.service.binding = {
            alt-shift-w = "mode main";

            # Join with direction
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

            # Exit service mode with escape
            esc = "mode main";
          };
        }
        cfg.settings
      ];
    };
  };
}
