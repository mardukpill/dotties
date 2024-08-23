{
  pkgs,
  namespace,
  lib,
  inputs,
  config,
  ...
}:
let
  inherit (lib) mkOption types mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.system.firewall;
in
{
  options.${namespace}.system.firewall.wireguard = {
    enable = mkBoolOpt false "whether to set rules to allow all traffic to be routed through a wireguard connection.";
    ports = mkOption {
      type = types.listOf types.port;
      default = [ 58844 ];
      description = "the allowed port numbers for wireguard to use.";
    };
  };

  config = mkIf cfg.wireguard.enable {
    networking.firewall = {
      logReversePathDrops = true;
      extraCommands = lib.concatStringsSep "\n" (
        map (port: ''
          ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport ${toString port} -j RETURN
          ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport ${toString port} -j RETURN
        '') cfg.wireguard.ports
      );
      extraStopCommands = lib.concatStringsSep "\n" (
        map (port: ''
          ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport ${toString port} -j RETURN || true
          ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport ${toString port} -j RETURN || true
        '') cfg.wireguard.ports
      );
    };
  };
}
