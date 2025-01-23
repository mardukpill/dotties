{
  pkgs,
  inputs,
  config,
  namespace,
  lib,
  ...
}:
let
  enabled = (config.${namespace}.wms.hyprland.theme == "acrylic");
in
{
  config = lib.mkIf enabled {
    colorScheme = inputs.nix-colors.colorSchemes.gruvbox-light-medium;

    gtk = {
      enable = true;
      theme = {
        name = "Gruvbox-Dark";
        package = pkgs.gruvbox-gtk-theme;
      };

      iconTheme = {
        name = "Gruvbox-Plus-Dark";
        package = pkgs.gruvbox-plus-icons;
      };

      font = {
        name = "Sans";
        size = 11;
      };
    };
  };
}
