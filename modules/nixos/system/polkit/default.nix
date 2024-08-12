{
  # https://github.com/khaneliman/khanelinix/blob/ff2d8725ce44dea5169b3623a6d6747e47804b4e/modules/nixos/security/polkit/default.nix #
  # this is a modified version of khaneliman's polkit module to use the polkit-gnome package instead. #
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.system.security.polkit;
in
{
  options.${namespace}.system.security.polkit = {
    enable = mkEnableOption "polkit-gnome.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ polkit_gnome ];

    security.polkit = {
      enable = true;
      debug = lib.mkDefault true;

      extraConfig = lib.mkIf config.security.polkit.debug ''
        /* Log authorization checks. */
        polkit.addRule(function(action, subject) {
          polkit.log("user " +  subject.user + " is attempting action " + action.id + " from PID " + subject.pid);
        });
      '';
    };

    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        after = [ "graphical-session.target" ];
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
  };
}
