{ lib, config, ... }:
let
  cfg = config.programs.niri.settings.outputs;
in
{
  # triple monitor setup with integrated display in middle
  "DP-4" = {
    enable = true;
    mode.width = 1920;
    mode.height = 1080;
    mode.refresh = 60.0;
    # transform = {
    #   rotation = 90;
    # };
    position.x = 0;
    position.y = 0;
  };
  "eDP-1" = {
    mode.width = 2560;
    mode.height = 1440;
    mode.refresh = 240.0;
    scale = 1.0;
    position.x = cfg."DP-4".mode.width;
    position.y = 0;
  };
  "DP-5" = {
    enable = true;
    mode.width = 1920;
    mode.height = 1080;
    mode.refresh = 60.0;
    # transform = {
    #   rotation = 90;
    # };
    position.x = cfg."eDP-1".mode.width + cfg."DP-4".mode.width;
    position.y = 0;
  };
}
