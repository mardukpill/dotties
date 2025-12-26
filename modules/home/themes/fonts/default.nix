{
  pkgs,
  inputs,
  config,
  namespace,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkOpt;

  cfg = config.${namespace}.system.fonts;
in
{
  options.${namespace}.system.fonts = {
    manage = mkOpt lib.types.bool true "whether to manage fonts.";
  };

  config = mkIf cfg.manage {
    home.packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.jetbrains-mono

      # material-icons
      # material-design-icons

      corefonts
      vista-fonts

      noto-fonts

      noto-fonts-color-emoji
      twemoji-color-font

      font-awesome
      roboto-mono
      montserrat
    ];

    fonts.fontconfig.enable = true;
  };
}
