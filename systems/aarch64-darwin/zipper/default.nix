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
    dotties.system.homebrew = enabled;

    dotties = {
      wms = {
        aerospace = enabled;
      };
      cli = {
        fish = enabled;
      };
    };

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
      yarn
      openconnect
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
