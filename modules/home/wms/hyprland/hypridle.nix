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
        after_sleep_cmd = "${getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch dpms on";
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
          on-timeout = "${getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch dpms off";
          on-resume = "${getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch dpms on";
        }
      ];
    };
  };
  systemd.user.services.hypridle.Install.WantedBy = mkIf enableModule [ "graphical-session.target" ];
}
