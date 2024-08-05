{
  # https://github.com/khaneliman/khanelinix/blob/4f69318cd30fb1c78e1c81dc6d33c45300f7d661/modules/nixos/programs/graphical/apps/steam/default.nix
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.apps.steam;
in
{
  options.${namespace}.apps.steam = {
    enable = mkBoolOpt false "Whether to enable support for Steam.";
  };

  config = mkIf cfg.enable {
    dotties.utility.gamemode = enabled;
    environment = {
      systemPackages = with pkgs; [ steamtinkerlaunch ];
    };

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;

      extraCompatPackages = [ pkgs.proton-ge-bin.steamcompattool ];
    };
  };
}
