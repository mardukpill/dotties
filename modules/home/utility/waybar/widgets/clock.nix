{ config, ... }:
let
  palette = config.colorScheme.palette;
in
{
  programs.waybar.settings.mainBar = {
    "clock" = {
      interval = 1;
      format = "{:%a %I:%M} 󰥔";
      format-alt = "{:%B %d, %Y (%I:%M:%S)}";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode = "year";
        mode-mon-col = 3;
        weeks-pos = "right";
        format = {
          months = "<span color='#${palette.base0D}'><b>{}</b></span>";
          days = "<span color='#${palette.base03}'><b>{}</b></span>";
          weeks = "<span color='#${palette.base0C}'><b>W{}</b></span>";
          weekdays = "<span color='#${palette.base05}'><b>{}</b></span>";
          today = "<span color='#${palette.base06}'><b><u>{}</u></b></span>";
        };
      };
      actions = {
        on-click-right = "mode";
        on-scroll-up = "shift_up";
        on-scroll-down = "shift_down";
      };
    };
  };
}
