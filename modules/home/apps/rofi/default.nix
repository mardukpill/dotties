{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.${namespace}.apps.rofi;
in
{
  options.${namespace}.apps.rofi = {
    enable = mkEnableOption "rofi.";
    wayland = mkOption {
      type = lib.types.bool;
      default = false;
      description = "whether to enable wayland support for rofi";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ wtype ];

    programs.rofi = {
      enable = true;
      package = mkIf (cfg.wayland) pkgs.rofi-wayland;
      theme = "${config.xdg.configHome}/rofi/rofi.rasi";

      plugins = with pkgs; [
        # FIXME: currently broken
        rofi-calc
        rofi-emoji
        rofi-top
      ];
    };

    xdg.configFile = {
      rofi = {
        source = lib.cleanSourceWith { src = lib.cleanSource ./config/.; };
        recursive = true;
      };
    };
  };
}
