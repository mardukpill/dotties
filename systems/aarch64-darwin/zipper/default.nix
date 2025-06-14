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
  name = lib.snowfall.system.get-inferred-system-name ./.;
in
{
  options = { };

  config = {
    homebrew = {
      enable = true;
      global.brewfile = true;
      onActivation = {
        cleanup = "zap";
      };
      brews = [
        "docker-compose"
      ];
      casks = [
        "firefox"
        "keepassxc"
        "docker"
        "iina"
      ];
    };

    dotties = {
      wms = {
        aerospace = {
          enable = true;
        };
      };
    };

    environment.systemPath = [ "/opt/homebrew/bin" ];
    environment.pathsToLink = [
      "/opt/homebrew/bin"
      "$HOME/.nix-profile/bin"
      "/run/current-system/sw/bin"
      "/nix/var/nix/profiles/default/bin"
      "/usr/local/bin"
    ];

    environment.systemPackages = with pkgs; [
      tmux
      firefox
      rectangle
      sbt
      yarn
      coursier
      metals
      scala
      openconnect
      scala-cli
      sbt
      sc
      jdk17
      zoom-us
      jetbrains.datagrip
    ];

    networking = {
      computerName = "Mike MacBook";
      hostName = name;
      localHostName = name;
    };

    nix.settings = {
      cores = 10;
      max-jobs = 8;
    };

    system = {
      primaryUser = "mike";
      stateVersion = 5;
    };
  };
}
