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
  inherit (lib)
    mkIf
    getExe
    types
    ;
  inherit (lib.${namespace})
    mkBoolOpt
    enabled
    mkOpt
    ;

  inherit (inputs) hypridle;

  cfg = config.${namespace}.services.hypridle;
in
{
  options.${namespace}.services.hypridle = {
    enable = mkBoolOpt false "hypridle";
    idleDelay =
      mkOpt types.ints.unsigned 300
        "The delay blanking before the screen turns off due to idling. Setting to 0 will disable screen idle blanking.";
    lockDelay =
      mkOpt types.ints.unsigned 240
        "The delay before the screen locks due to idling. Setting to 0 will disable idle locking.";

  };
  config = mkIf cfg.enable {
    dotties.utility.hyprlock = enabled;
    services.hypridle = {
      enable = true;
      package = hypridle.packages.${system}.hypridle;

      settings = {
        general = {
          after_sleep_cmd = "niri action power-off-monitors";
          before_sleep_cmd = "hyprlock --immediate";
          ignore_dbus_inhibit = false;
          lock_cmd = "${getExe config.programs.hyprlock.package}";
        };

        listener = [
          {
            timeout = cfg.lockDelay;
            on-timeout = "${getExe config.programs.hyprlock.package}";
          }
          {
            timeout = cfg.idleDelay;
            on-timeout = "${getExe pkgs.niri} msg action power-off-monitors";
            # on-resume = "niri msg action power-on-monitors";
          }
        ];
      };
    };
    systemd.user.services.hypridle.Install.WantedBy = mkIf cfg.enable [ "graphical-session.target" ];
  };
}
