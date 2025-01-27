{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  theme = config.${namespace}.wms.hyprland.theme;
  themes = {
    "rose-pine" = {
      borderColor = "#" + config.colorScheme.palette.base04;
      borderSize = 3;
      borderRadius = 5;
      backgroundColor = "#" + config.colorScheme.palette.base07;
      progressColor = "over #" + config.colorScheme.palette.base0F + "FF";
    };
    "acrylic" = {
      textColor = "#" + config.colorScheme.palette.base00;
      borderColor = "#" + config.colorScheme.palette.base04;
      borderSize = 3;
      borderRadius = 2;
      backgroundColor = "#" + config.colorScheme.palette.base07;
      progressColor = "over #" + config.colorScheme.palette.base0F + "AA";
    };
  };

  cfg = config.${namespace}.utility.mako;
in
{
  options.${namespace}.utility.mako = {
    enable = mkEnableOption "mako.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libnotify
      mako
    ];

    services.mako = themes.${theme} // {
      enable = true;
      icons = true;
      defaultTimeout = 5000;
      anchor = "bottom-right";
      font = "JetBrainsMono bold 14";
      height = 300;
      width = 500;
      padding = "10,15,20";
      layer = "overlay";

      extraConfig = ''
        outer-margin=25

        [app-name=Spotify]
        border-color=#1DB954
        font=JetBrainsMono bold 18
        anchor=bottom-center
        default-timeout=3000
        ignore-timeout=1
        padding=5,5,5
        outer-margin=25
        height=100
        width=900
        text-alignment=center
      '';
    };

  };
}
