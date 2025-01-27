{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkOpt;

  cfg = config.${namespace}.system.core;
in
{
  options.${namespace}.system.core = {
    enable = mkOpt lib.types.bool true "core system configuration.";
  };

  config = mkIf cfg.enable {

    system.stateVersion = "23.05";

  };
}
