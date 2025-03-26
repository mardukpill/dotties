{
  pkgs,
  inputs,
  config,
  namespace,
  lib,
  ...
}:
let
  enabled = (config.${namespace}.wms.theme == "rose-pine");
in
{
  config = lib.mkIf enabled {
    colorScheme = inputs.nix-colors.colorSchemes.rose-pine;

    gtk = {
      enable = true;
      theme = {
        name = "rose-pine";
        package = pkgs.rose-pine-gtk-theme;
      };

      iconTheme = {
        name = "rose-pine";
        package = pkgs.rose-pine-icon-theme;
      };

      font = {
        name = "Sans";
        size = 11;
      };
    };
  };
}
