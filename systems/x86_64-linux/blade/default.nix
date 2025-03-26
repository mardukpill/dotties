{
  config,
  lib,
  namespace,
  inputs,
  pkgs,
  ...
}:
let
  # sddm-wallpaper = pkgs.fetchurl {
  #   url = "https://ploop.city/home.png";
  #   sha256 = "ca39463acd764102888c8cb859b856fd6fb8f974d8bc527827da3017c9210d18";
  # };
  inherit (lib.${namespace}) enabled;
in
{
  imports = [
    ./boot.nix
    ./specialisations.nix
    ./disks.nix
    ./hardware-configuration.nix
    ./power.nix
  ];

  environment.systemPackages = with pkgs; [
    arduino-ide
    arduino-core
  ];

  programs.file-roller = enabled;

  ${namespace} = {
    user = {
      extraGroups = [
        "wheel"
        "video"
        "input"
        "tty"
        "dialout"
      ];
    };

    hw = {
      nvidia = {
        enable = true;
        version = "default";
      };
      razer = enabled;
    };

    ai = {
      ollama = enabled;
    };

    apps = {
      bottles = enabled;
      thunar = enabled;
      thunderbird = enabled;
      wireshark = enabled;
      steam = enabled;
      obs = enabled;
    };

    dms.sddm = {
      enable = true;
      theme = {
        style = "where-is-my-sddm-theme";
        # background = sddm-wallpaper;
      };
    };

    system = {
      bluetooth = enabled;
      networking = enabled;
      docker = enabled;
      adb = enabled;
      nix-alien = enabled;
      nix = {
        managed = true;
        nixHelper = true;
      };
      security.polkit = enabled;

      firewall = {
        wireguard = {
          enable = true;
          ports = [ 49094 ];
        };
      };
    };

    cli = {
      fish = enabled;
    };

    wms = {
      niri = enabled;
    };

  };

  networking = {
    hostName = lib.snowfall.system.get-inferred-system-name ./.;
  };
}
