{
  lib,
  config,
  ...
}:
with lib;
let
  Mod = "Mod";
  binds =
    {
      suffixes,
      prefixes,
      substitutions ? { },
    }:
    let
      replacer = replaceStrings (attrNames substitutions) (attrValues substitutions);
      format =
        prefix: suffix:
        let
          actual-suffix =
            if isList suffix.action then
              {
                action = head suffix.action;
                args = tail suffix.action;
              }
            else
              {
                inherit (suffix) action;
                args = [ ];
              };

          action = replacer "${prefix.action}-${actual-suffix.action}";
        in
        {
          name = "${prefix.key}+${suffix.key}";
          value.action.${action} = actual-suffix.args;
        };
      pairs =
        attrs: fn:
        concatMap (
          key:
          fn {
            inherit key;
            action = attrs.${key};
          }
        ) (attrNames attrs);
    in
    listToAttrs (pairs prefixes (prefix: pairs suffixes (suffix: [ (format prefix suffix) ])));
in
lib.attrsets.mergeAttrsList (
  with config.lib.niri.actions;
  [
    {
      "${Mod}+Tab".action = toggle-overview;
      # "${Mod}+Tab".action = focus-window-down-or-column-right;
      # "${Mod}+Shift+Tab".action = focus-window-up-or-column-left;

      "${Mod}+space".action = toggle-column-tabbed-display;

      "Mod+Left".action = focus-column-left;
      "Mod+Down".action = focus-window-down;
      "Mod+Up".action = focus-window-up;
      "Mod+Right".action = focus-column-right;
      "Mod+H".action = focus-column-left;
      "Mod+J".action = focus-window-down;
      "Mod+K".action = focus-window-up;
      "Mod+L".action = focus-column-right;

      "Mod+Ctrl+Left".action = move-column-left;
      "Mod+Ctrl+Down".action = move-window-down;
      "Mod+Ctrl+Up".action = move-window-up;
      "Mod+Ctrl+Right".action = move-column-right;
      "Mod+Ctrl+H".action = move-column-left;
      "Mod+Ctrl+J".action = move-window-down;
      "Mod+Ctrl+K".action = move-window-up;
      "Mod+Ctrl+L".action = move-column-right;

      # Alternative commands that move across workspaces when reaching
      # the first or last window in a column.
      # Mod+J     { focus-window-or-workspace-down; }
      # Mod+K     { focus-window-or-workspace-up; }
      # Mod+Ctrl+J     { move-window-down-or-to-workspace-down; }
      # Mod+Ctrl+K     { move-window-up-or-to-workspace-up; }

      "Mod+Home".action = focus-column-first;
      "Mod+End".action = focus-column-last;
      "Mod+Ctrl+Home".action = move-column-to-first;
      "Mod+Ctrl+End".action = move-column-to-last;

      "Mod+Shift+Left".action = focus-monitor-left;
      "Mod+Shift+Down".action = focus-monitor-down;
      "Mod+Shift+Up".action = focus-monitor-up;
      "Mod+Shift+Right".action = focus-monitor-right;
      "Mod+Shift+H".action = focus-monitor-left;
      "Mod+Shift+J".action = focus-monitor-down;
      "Mod+Shift+K".action = focus-monitor-up;
      "Mod+Shift+L".action = focus-monitor-right;

      "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
      "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
      "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
      "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
      "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
      "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

      # Alternatively, there are commands to move just a single window:
      # Mod+Shift+Ctrl+Left  { move-window-to-monitor-left; }
      # ...

      # And you can also move a whole workspace to another monitor:
      # Mod+Shift+Ctrl+Left  { move-workspace-to-monitor-left; }
      # ...

      "Mod+U".action = focus-workspace-down;
      "Mod+I".action = focus-workspace-up;
      "Mod+Ctrl+U".action = move-column-to-workspace-down;
      "Mod+Ctrl+I".action = move-column-to-workspace-up;

      # Alternatively, there are commands to move just a single window:
      # Mod+Ctrl+Page_Down { move-window-to-workspace-down; }
      # ...

      "Mod+Shift+U".action = move-workspace-down;
      "Mod+Shift+I".action = move-workspace-up;

      # You can bind mouse wheel scroll ticks using the following syntax.
      # These binds will change direction based on the natural-scroll setting.
      #
      # To avoid scrolling through workspaces really fast, you can use
      # the cooldown-ms property. The bind will be rate-limited to this value.
      # You can set a cooldown on any bind, but it's most useful for the wheel.
      "Mod+WheelScrollDown".action = focus-workspace-down;
      "Mod+WheelScrollUp".action = focus-workspace-up;
      "Mod+Ctrl+WheelScrollDown".action = move-column-to-workspace-down;
      "Mod+Ctrl+WheelScrollUp".action = move-column-to-workspace-up;

      "Mod+WheelScrollRight".action = focus-column-right;
      "Mod+WheelScrollLeft".action = focus-column-left;
      "Mod+Ctrl+WheelScrollRight".action = move-column-right;
      "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

      # Usually scrolling up and down with Shift in applications results in
      # horizontal scrolling; these binds replicate that.
      "Mod+Shift+WheelScrollDown".action = focus-column-right;
      "Mod+Shift+WheelScrollUp".action = focus-column-left;
      "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
      "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;

      # Similarly, you can bind touchpad scroll "ticks".
      # Touchpad scrolling is continuous, so for these binds it is split into
      # discrete intervals.
      # These binds are also affected by touchpad's natural-scroll, so these
      # example binds are "inverted", since we have natural-scroll enabled for
      # touchpads by default.
      # Mod+TouchpadScrollDown { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"; }
      # Mod+TouchpadScrollUp   { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"; }

      # Switches focus between the current and the previous workspace.
      # Mod+Tab { focus-workspace-previous; }

      # The following binds move the focused window in and out of a column.
      # If the window is alone, they will consume it into the nearby column to the side.
      # If the window is already in a column, they will expel it out.
      "Mod+BracketLeft".action = consume-or-expel-window-left;
      "Mod+BracketRight".action = consume-or-expel-window-right;

      # Consume one window from the right to the bottom of the focused column.
      "Mod+Comma".action = consume-window-into-column;
      # Expel the bottom window from the focused column to the right.
      "Mod+Period".action = expel-window-from-column;

      "Mod+R".action = switch-preset-column-width;
      "Mod+Shift+R".action = switch-preset-window-height;
      "Mod+Ctrl+R".action = reset-window-height;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;

      # Expand the focused column to space not taken up by other fully visible columns.
      # Makes the column "fill the rest of the space".
      "Mod+Ctrl+F".action = expand-column-to-available-width;

      "Mod+C".action = center-column;

      # Finer width adjustments.
      # This command can also:
      # * set width in pixels: "1000"
      # * adjust width in pixels: "-5" or "+5"
      # * set width as a percentage of screen width: "25%"
      # * adjust width as a percentage of screen width: "-10%" or "+10%"
      # Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
      # set-column-width "100" will make the column occupy 200 physical screen pixels.
      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";

      # Finer height adjustments when in column with other windows.
      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";

      # Move the focused window between the floating and the tiling layout.
      "Mod+V".action = toggle-window-floating;
      "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
    }
    (binds {
      suffixes = builtins.listToAttrs (
        map (n: {
          name = toString n;
          value = [
            "workspace"
            (n)
          ]; # workspace 1 is empty; workspace 2 is the logical first.
        }) (range 1 9)
      );
      prefixes."${Mod}" = "focus";
      prefixes."${Mod}+Ctrl" = "move-window-to";
    })
  ]
)
