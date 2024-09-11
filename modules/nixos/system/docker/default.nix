{
  pkgs,
  namespace,
  lib,
  inputs,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) enabled;
  cfg = config.${namespace}.system.docker;
in
{
  options.${namespace}.system.docker = {
    enable = mkEnableOption "docker.";
  };

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
    };
    dotties.user.extraGroups = [ "docker " ];
  };
}
