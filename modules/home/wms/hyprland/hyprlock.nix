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
  inherit (lib) mkIf;
  palette = config.colorScheme.palette;

  inherit (inputs) hyprlock;

  cfg = config.${namespace}.wms.hyprland;
in
{
  config = mkIf (cfg.lockDelay != 0) {
    programs.hyprlock = {
      enable = true;
      package = hyprlock.packages.${system}.hyprlock;

      settings = {
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
          grace = 30;
          no_fade_in = false;
          no_fade_out = false;
        };

        background = [
          {
            monitor = "";
            brightness = "0.817200";
            color = "rgba(25, 20, 20, 1.0)";
            path = "screenshot";
            blur_passes = 3;
            blur_size = 8;
            contrast = "0.891700";
            noise = "0.011700";
            vibrancy = "0.168600";
            vibrancy_darkness = "0.050000";
          }
        ];

        input-field = [
          {
            monitor = "";
            size = "400, 80";
            position = "0, 30";
            outline_thickness = 5;
            dots_center = true;
            outer_color = "rgba(${palette.base0F}00)";
            inner_color = "rgba(${palette.base0F}00)";
            font_color = "rgb(${palette.base0F})";
            font_size = 84;
            fade_on_empty = false;
            placeholder_text = "<span foreground=\"##${palette.base0F}\">Password...</span>";
            shadow_passes = 0;
            bothlock_color = -1;
            capslock_color = "-1";
            check_color = "rgb(204, 136, 34)";
            dots_rounding = "-1";
            dots_size = "0.330000";
            dots_spacing = "0.150000";
            fade_timeout = "2000";
            fail_color = "rgb(${palette.base08})";
            fail_text = "<i>$FAIL</i>";
            fail_transition = 300;
            halign = "center";
            hide_input = false;
            invert_numlock = false;
            numlock_color = -1;
            swap_font_color = false;
            valign = "center";
          }
        ];
        label = [
          {
            monitor = "";
            text = "<span font_weight=\"ultrabold\">$TIME</span>";
            color = "rgb(${palette.base04})";
            font_size = 100;
            font_family = "JetBrainsMono Nerd Font";
            valign = "center";
            halign = "center";
            position = "0, 330";
            shadow_passes = 2;
            rotate = "0.000000";
            shadow_boost = "1.200000";
            shadow_color = "rgba(0, 0, 0, 1.0)";
            shadow_size = 3;
          }
          {
            monitor = "";
            text = "<span font_weight=\"bold\"> $USER</span>";
            color = "rgb(${palette.base0D})";
            font_size = 25;
            font_family = "JetBrainsMono Nerd Font";
            valign = "top";
            halign = "left";
            position = "10, 0";
            shadow_passes = 1;
            rotate = "0.000000";
            shadow_boost = "1.200000";
            shadow_color = "rgba(0, 0, 0, 1.0)";
            shadow_size = 3;
          }
          {
            monitor = "";
            text = "cmd[update:120000] echo \"<span font_weight='bold'>$(date +'%a %d %B')</span>\"";
            color = "rgb(${palette.base04})";
            font_size = 30;
            font_family = "JetBrainsMono Nerd Font";
            valign = "center";
            halign = "center";
            position = "0, 210";
            shadow_passes = 1;
            rotate = "0.000000";
            shadow_boost = "1.200000";
            shadow_color = "rgba(0, 0, 0, 1.0)";
            shadow_size = 3;
          }
          {
            monitor = "";
            text = "<span font_weight=\"ultrabold\"> </span>";
            color = "rgb(${palette.base03})";
            font_size = 25;
            font_family = "JetBrainsMono Nerd Font";
            valign = "bottom";
            halign = "right";
            position = "5, 8";
            shadow_passes = 1;
            rotate = "0.000000";
            shadow_boost = "1.200000";
            shadow_color = "rgba(0, 0, 0, 1.0)";
            shadow_size = 3;
          }
        ];
      };
    };
  };
}
