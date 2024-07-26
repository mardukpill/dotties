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

  cfg = config.${namespace}.suites.personal;
in
{
  options.${namespace}.suites.personal = {
    enable = mkEnableOption "personal computing suite.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      firefox
      vesktop
      keepassxc
    ];
    services.syncthing.enable = true;
  };
}
