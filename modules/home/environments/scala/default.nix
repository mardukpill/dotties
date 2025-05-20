{
  namespace,
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.${namespace}) mkBoolOpt;
  inherit (lib) mkIf;
  cfg = config.${namespace}.environments.scala;
in
{
  options.${namespace}.environments.scala = {
    enable = mkBoolOpt false "scala dev environment. ";
  };

  config = mkIf cfg.enabler {
    environment.systemPackages = with pkgs; [
      coursier
      metals
    ];
  };
}
