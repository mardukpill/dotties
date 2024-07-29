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

  cfg = config.${namespace}.utility.anyrun;
  anyrun = inputs.anyrun;
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
          # kidex
          rink
          symbols
          shell
          dictionary
          # randr
        ];
        width.fraction = 0.2;
        # x.fraction = 0.1;
        y.fraction = 0.2;
        hidePluginInfo = true;
        closeOnClick = true;
      };
      extraCss = builtins.readFile ./theme.css; # TODO: don't use static colors
    };
  };
}
