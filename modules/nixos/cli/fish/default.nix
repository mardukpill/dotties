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
      interactiveShellInit = ''
        nix-your-shell fish | source
      '';
    };
  };
}
