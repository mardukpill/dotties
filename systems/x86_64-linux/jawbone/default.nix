{
  config,
  lib,
  namespace,
  inputs,
  pkgs,
  ...
}:
let
  inherit (lib.${namespace}) enabled;
in
{
  imports = [
    ./boot.nix
    ./disks.nix
    ./hardware-configuration.nix
    ./specialisations.nix
  ];

  # TODO: install n/vim
  # nginx
  # wireguard
  # use selinux
  # fail2ban
  # iptables

  ${namespace} = {
    system = {
      docker = enabled;
      nix = {
        managed = true;
        nixHelper = true;
      };
      security.polkit = enabled;

      firewall = {
        wireguard = enabled;
      };
    };

    cli = {
      fish = enabled;
    };
  };
  networking = {
    hostName = lib.snowfall.system.get-inferred-system-name ./.;
    networkmanager = enabled;
  };

  system.stateVersion = "23.05";
}
