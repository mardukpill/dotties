{
  pkgs,
  namespace,
  lib,
  inputs,
  config,
  ...
}:
with lib;
let
  inherit (lib) namespace;
  cfg = config.${namespace}.system.nix;
in
{
  options.${namespace}.services.plex = {
    enable = mkEnableOption "Plex Media Server.";
    zurg = mkEnableOption "zurg.";
  };

  config = mkIf cfg.enable {
    services.plex = {
      enable = true;
      openFirewall = true;
    };

    virtualisation.docker.enable = cfg.zurg;
    dotties.user.extraGroups = mkIf cfg.zurg [ "docker" ];
  };
}
