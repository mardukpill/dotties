{
  pkgs,
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.hw.razer;
in
{
  options.${namespace}.hw.razer = {
    enable = mkEnableOption "razer blade tools.";
  };

  config = mkIf cfg.enable {
    services = {
      razer-laptop-control.enable = true;
      # udev.extraRules = ''
      #   KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="plugdev"
      # ''; # needed for correct permissions for razer-laptop-control
    };

    environment.systemPackages = with pkgs; [ polychromatic ];

    # dotties.user.extraGroups = [ "plugdev" ];
  };
}
