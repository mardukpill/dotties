{ pkgs, inputs, ... }:
{
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

}
