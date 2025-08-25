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

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      coursier
      metals
      scala
      scala-cli
      sbt
      sc
      jdk17
    ];
  };
}
