{
  pkgs,
  system,
  namespace,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.cli.fish;
in
{
  options.${namespace}.cli.fish = {
    enable = mkEnableOption "fish shell.";
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [ nix-your-shell ];
      shells = [ pkgs.fish ];
    };

    programs.fish = {
      enable = true;
      shellInit = mkIf config.${namespace}.system.nix.comma ''
        set -gx NIX_PATH github:NixOS/nixpkgs-unstable
      '';
      interactiveShellInit = ''
        nix-your-shell fish | source
      '';
    };
  };
}
