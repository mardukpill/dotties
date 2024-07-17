{
  lib,
  namespace,
  config,
  pkgs,
  ...
}@attrs:
let
  inherit (lib)
    mkIf
    mkEnableOption
    mkOption
    types
    ;

  cfg = config.${namespace}.dms.sddm;
in
{
  options.${namespace}.dms.sddm = {
    enable = mkEnableOption "sddm";
    theme.style = mkOption {
      type = types.enum [ "where-is-my-sddm-theme" ];
      default = "where-is-my-sddm-theme";
      description = "which sddm theme to use";
    };
    theme.background = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Path to the background of the sddm theme.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ libsForQt5.qt5.qtgraphicaleffects ];
    services.displayManager = {
      defaultSession = "hyprland"; # FIXME: should be dynamically set
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "${import ./where-is-my-sddm-theme.nix attrs}";
      };
    };
  };
}
