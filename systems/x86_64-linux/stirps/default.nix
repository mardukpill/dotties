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

  sddm-wallpaper = pkgs.fetchurl {
    url = "https://ploop.city/home.png";
    sha256 = "ca39463acd764102888c8cb859b856fd6fb8f974d8bc527827da3017c9210d18";
  };
in
{
  imports = [
    ./boot.nix
    ./hardware-configuration.nix
  ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGsgZIUxHRpzYHhLfa2CNmZnuyr5omNyK5rbSWeBnqY3 mike@blade"
  ];
  networking.firewall.checkReversePath = false;

  dotties = {
    user = {
      extraGroups = [
        "wheel"
        "input"
      ];
    };

    services.plex = {
      enable = true;
      zurg = true;
    };

    hw = {
      nvidia = {
        enable = true;
        version = "535";
      };
    };

    apps = {
      thunar = enabled;
      thunderbird = enabled;
      steam = enabled;
    };

    dms.sddm = {
      enable = true;
      theme = {
        style = "where-is-my-sddm-theme";
        background = sddm-wallpaper;
      };
    };

    system.nix = {
      managed = true;
      nixHelper = true;
      comma = true;
    };

    cli = {
      fish = enabled;
    };

    wms = {
      hyprland = enabled;
    };
  };

  networking = {
    hostName = lib.snowfall.system.get-inferred-system-name ./.;
    networkmanager = enabled;
  };

  system.stateVersion = "23.05";
}
