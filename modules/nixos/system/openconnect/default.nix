{
  pkgs,
  config,
  namespace,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.system.openconnect;
in
{
  options.${namespace}.system.openconnect = {
    enable = mkEnableOption "openconnect.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      openconnect
    ];

    systemd.services.tun0-mtu = {
      description = "Set MTU for tun0";
      after = [ "sys-devices-virtual-net-tun0.device" ];
      wants = [ "sys-devices-virtual-net-tun0.device" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.iproute2}/bin/ip link set tun0 mtu 1200";
        RemainAfterExit = "yes";
      };
      unitConfig = {
        ConditionPathExists = "/sys/class/net/tun0";
      };
    };

  };
}
