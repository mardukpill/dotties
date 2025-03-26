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
      theme = "rose-pine";
      niri = {
        enable = true;
      };
    };
  };

  home.packages = with pkgs; [
    godot_4
    tetrio-desktop
    bitwig-studio
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
