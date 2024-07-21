{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.apps.wireshark;
in
{
  options.${namespace}.apps.wireshark = {
    enable = mkEnableOption "Wireshark.";
  };

  config = mkIf cfg.enable {
    programs.wireshark.enable = true;
    environment.systemPackages = with pkgs; [ wireshark ];

    dotties.user.extraGroups = [ "wireshark" ];
  };
}
