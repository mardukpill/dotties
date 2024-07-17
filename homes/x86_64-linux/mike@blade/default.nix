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
  snowfallorg.user = {
    name = "mike";
    enable = true;
  };

  dotties = {
    cli = {
      neovim = enabled;
      tools = enabled;
      fish = enabled;
    };
    apps = {
      spotify = {
        enable = true;
        spicetify = true;
      };
      alacritty = enabled;
      imv = enabled;
      mpv = enabled;
    };

    wms.hyprland = enabled;
  };

  home.packages = with pkgs; [
    vesktop
    keepassxc

    dotties.bluemail-with-gpu
    firefox
    thunderbird

    playerctl

    ffmpeg # media management
    yt-dlp
    imagemagick

    zathura
    viewnior
    gobble

    libreoffice-fresh
    godot_4
  ];

  services.syncthing.enable = true;
  services.playerctld.enable = true;

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

  home.stateVersion = "23.05";
}
