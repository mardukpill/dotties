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
  ];

  dotties = {
    hw = {
      nvidia = {
        enable = true;
        version = "535";
      };
      razer = enabled;
    };

    apps = {
      thunar = enabled;
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
    };

    cli = {
      fish = enabled;
    };

    wms = {
      hyprland = enabled;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  networking = {
    hostName = lib.snowfall.system.get-inferred-system-name ./.;
    networkmanager = enabled;
  };

  system.stateVersion = "23.05";
}
