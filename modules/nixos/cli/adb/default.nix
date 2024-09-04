{
  pkgs,
  namespace,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.system.adb;
in
{
  options.${namespace}.system.adb = {
    enable = mkEnableOption "adb and android sdk";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ android-tools ];

    programs.adb = {
      enable = true;
    };

    dotties.user.extraGroups = [ "adbusers" ];
  };
}
