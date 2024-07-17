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
in
{
  config = mkIf cfg.enable {
    gtk = {
      # TODO: make separate theme module
      enable = true;
      theme = {
        name = "rose-pine";
        package = pkgs.rose-pine-gtk-theme;
      };

      iconTheme = {
        package = pkgs.rose-pine-icon-theme;
        name = "Rose-Pine-Icon-Theme";
      };

      font = {
        name = "Sans";
        size = 11;
      };
    };

    wayland.windowManager.hyprland = {
      settings = {
        "$dim" = "decoration:dim_inactive";

        # decorations
        "general:gaps_out" = 4;
        "general:gaps_in" = 3;
        "general:border_size" = 3;
        "general:col.active_border" = "rgba(${config.colorScheme.palette.base08}AA)";
        "general:col.inactive_border" = "rgba(${config.colorScheme.palette.base00}FF)";
        "decoration:rounding" = 7;

        animations = {
          enabled = "yes";
          first_launch_animation = true;

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
          bezier = [
            "easein, 0.47, 0, 0.745, 0.715"
            "myBezier, 0.05, 0.9, 0.1, 1.05"
            "overshot, 0.13, 0.99, 0.29, 1.1"
            "scurve, 0.98, 0.01, 0.02, 0.98"
          ];
          animation = [
            "border, 1, 10, default"
            "fade, 1, 10, default"
            "windows, 1, 5, overshot, popin 10%"
            "windowsOut, 1, 7, default, popin 10%"
            "workspaces, 1, 6, overshot, slide"
          ];
        };

      };
    };
  };
}
