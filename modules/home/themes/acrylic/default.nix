{
  pkgs,
  inputs,
  config,
  namespace,
  lib,
  ...
}:
let
  enabled = (config.${namespace}.wms.theme == "acrylic");
in
{
  config = lib.mkIf enabled {
    colorScheme = inputs.nix-colors.colorSchemes.gruvbox-light-medium;

    gtk = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
      enable = true;
      theme = {
        name = "Gruvbox-Dark";
        package = pkgs.gruvbox-gtk-theme;
      };

      iconTheme = {
        name = "Zafiro-icons-light";
        package = pkgs.zafiro-icons;
      };

      font = {
        name = "Sans";
        size = 11;
      };
    };
  };
}
