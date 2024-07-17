{
  namespace,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.utility.waybar;
in
{
  options.${namespace}.utility.waybar = {
    enable = mkEnableOption "waybar";
  };

  imports = lib.snowfall.fs.get-non-default-nix-files ./widgets;

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
        target = "hyprland-session.target";
      };
      style =
        ''
          @define-color background #${config.colorScheme.palette.base00};
          @define-color first #${config.colorScheme.palette.base01};
          @define-color second #${config.colorScheme.palette.base02};
          @define-color third #${config.colorScheme.palette.base03};
          @define-color fourth #${config.colorScheme.palette.base04};
          @define-color fifth #${config.colorScheme.palette.base05};
          @define-color sixth #${config.colorScheme.palette.base06};
          @define-color foregroundalt #${config.colorScheme.palette.base07};
          @define-color backgroundalt #${config.colorScheme.palette.base08};
          @define-color firstalt #${config.colorScheme.palette.base09};
          @define-color secondalt #${config.colorScheme.palette.base0A};
          @define-color thirdalt #${config.colorScheme.palette.base0B};
          @define-color fourthalt #${config.colorScheme.palette.base0C};
          @define-color fifthalt #${config.colorScheme.palette.base0D};
          @define-color sixthalt #${config.colorScheme.palette.base0E};
          @define-color foreground #${config.colorScheme.palette.base0F};
        ''
        + builtins.readFile ./styles.css; # hacky way of getting the colorscheme into the css

      settings = {
        mainBar = {
          layer = "bottom";
          position = "top";
          height = 45;
          margin-left = 1;
          margin-right = 1;
          output = [ "eDP-1" ];
          modules-left = [
            "tray"
            "hyprland/workspaces"
          ];
          modules-center = [ "hyprland/window" ];
          modules-right = [
            "network"
            "cpu"
            "pulseaudio"
            "battery"
            "clock"
          ];
        };
      };
    };
  };
}
