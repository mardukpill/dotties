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
  cfg = config.${namespace}.system.nix-alien;
in
{
  options.${namespace}.system.nix-alien = {
    enable = mkEnableOption "nix-alien.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ nix-alien ];
    programs.nix-ld = enabled;
  };
}
