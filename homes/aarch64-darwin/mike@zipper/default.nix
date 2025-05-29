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
    cli = {
      neovim = enabled;
      tools = enabled;
      fish = enabled;
    };
    apps = {
      alacritty = enabled;
    };
  };

  home.packages = with pkgs; [
  ];

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
