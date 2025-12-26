{
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib.${namespace}) enabled;
in
{
  dotties = {
    environments = {
      scala = enabled;
    };
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
      kodi = enabled;
      spotify = enabled;
      alacritty = enabled;
      minecraft = enabled;
    };

    wms = {
      theme = "acrylic";
      niri = {
        enable = true;
      };
      hyprland = {
        # enable = true;
      };
    };
  };

  home.packages = with pkgs; [
    tetrio-desktop
    distrobox
  ];

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
