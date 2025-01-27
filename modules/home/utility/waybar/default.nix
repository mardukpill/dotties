{
  namespace,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) defineCssColors;

  palette = config.colorScheme.palette;
  theme = config.${namespace}.wms.hyprland.theme;

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
        target = "graphical-session.target";
      };
      style = (defineCssColors palette) + (builtins.readFile ./${theme}.css);

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
