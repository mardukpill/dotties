{
  config,
  lib,
  namespace,
  inputs,
  pkgs,
  ...
}:
let
  sddm-wallpaper = pkgs.fetchurl {
    url = "https://ploop.city/home.png";
    sha256 = "ca39463acd764102888c8cb859b856fd6fb8f974d8bc527827da3017c9210d18";
  };
  inherit (lib.${namespace}) enabled;
in
{
  imports = [
    ./boot.nix
    ./disks.nix
    ./hardware-configuration.nix
  ];

  dotties = {
    user = {
      extraGroups = [
        "wheel"
        "video"
        "input"
      ];
    };

    hw = {
      nvidia = {
        enable = true;
        version = "535";
      };
      razer = enabled;
    };

    apps = {
      bottles = enabled;
      thunar = enabled;
      thunderbird = enabled;
      wireshark = enabled;
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
      comma = true;
      nixHelper = true;
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
