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
  "${namespace}" = {
    suites = {
      office = enabled;
      personal = enabled;
      av = enabled;
    };
    cli = {
      neovim = enabled;
      tools = enabled;
      fish = enabled;
    };
    apps = {
      spotify = {
        enable = true;
      };
      alacritty = enabled;
    };

    wms = {
      hyprland = {
        enable = true;
        idleDelay = 180;
        lockDelay = 0;
      };
    };
  };

  services.ssh-agent.enable = true;
  programs.ssh = {
    matchBlocks = {
      "github.com-mardukpill" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  snowfallorg.user = {
    name = "mike";
    enable = true;
  };

  home.stateVersion = "23.05";
}
