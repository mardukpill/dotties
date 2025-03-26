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
  inherit (lib) mkIf getExe' getExe;

  inherit (inputs) hypridle;

  cfg = config.${namespace}.wms.hyprland;
  enableModule = (cfg.idleDelay != 0 && cfg.lockDelay != 0);
in
{
  services.hypridle = mkIf enableModule {
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
          on-timeout = "niri action power-off-monitors";
          on-resume = "niri action power-on-monitors";
        }
      ];
    };
  };
  systemd.user.services.hypridle.Install.WantedBy = mkIf enableModule [ "graphical-session.target" ];
}
