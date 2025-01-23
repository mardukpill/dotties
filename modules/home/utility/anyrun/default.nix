{
  pkgs,
  lib,
  config,
  namespace,
  inputs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) defineCssColors;

  theme = config.${namespace}.wms.hyprland.theme;
  palette = config.colorScheme.palette;

  cfg = config.${namespace}.utility.anyrun;
  anyrun = inputs.anyrun;

  themes = {
    "rose-pine" = {
      width.fraction = 0.2;
      y.fraction = 0.2;
    };
    "acrylic" = {
      x.fraction = 0.125;
      y.fraction = 0.5;
      height.fraction = 1.0;
      width.fraction = 0.25;
    };
  };
in
{
  options.${namespace}.utility.anyrun = {
    enable = mkEnableOption "anyrun.";
  };

  config = mkIf cfg.enable {
    programs.anyrun = {
      enable = true;
      config = {
        plugins = with anyrun.packages.${pkgs.system}; [
          applications
          rink
          symbols
          shell
          dictionary
          randr
        ];
        hidePluginInfo = true;
        closeOnClick = true;
      } // themes.${theme};
      extraCss = (defineCssColors palette) + builtins.readFile ./themes/${theme}.css;
    };
  };
}
