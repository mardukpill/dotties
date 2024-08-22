{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) types mkIf mkEnableOption;

  cfg = config.${namespace}.utility.brillo;
in
{
  options.${namespace}.utility.brillo = with types; {
    enable = mkEnableOption "brillo";
  };

  config = mkIf cfg.enable {
    dotties.user.extraGroups = [ "video" ];

    environment.systemPackages = with pkgs; [ brillo ];
  };
}
