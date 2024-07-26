{
  lib,
  pkgs,
  namespace,
  system,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.suites.office;
in
{
  options.${namespace}.suites.office = {
    enable = mkEnableOption "a suite of office applications.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zathura
      libreoffice-fresh
    ];
  };
}
