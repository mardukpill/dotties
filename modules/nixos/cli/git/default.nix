{
  pkgs,
  namespace,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkOpt;

  cfg = config.${namespace}.system.git;
in
{
  options.${namespace}.system.git = {
    enable = mkOpt lib.types.bool true "whether to manage git configuration";
  };

  config = mkIf cfg.enable { environment.systemPackages = with pkgs; [ git ]; };
}
