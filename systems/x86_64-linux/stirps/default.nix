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
    ./hardware-configuration.nix
  ];

  dotties = {
    user = {
      extraGroups = [
        "wheel"
        "input"
      ];
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
      wireshark = enabled;
      steam = enabled;
    };

    dms.sddm = {
      enable = true;
      theme = {
        style = "where-is-my-sddm-theme";
        background = pkgs.fetchurl {
          url = "https://ploop.city/home.png";
          sha256 = "ca39463acd764102888c8cb859b856fd6fb8f974d8bc527827da3017c9210d18";
        };
      };
    };

    system.nix = {
      managed = true;
      useHelper = true;
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
