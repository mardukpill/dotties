# ./modules/darwin/cli/fish/default.nix
{
  pkgs,
  namespace,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.cli.fish;
in
{
  options.${namespace}.cli.fish = {
    enable = mkEnableOption "fish shell.";
  };

  config = mkIf cfg.enable {
    environment.shells = [ pkgs.fish ];
    programs.fish.enable = true;

    environment.systemPath = [
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
    ];

    users.users.${config.system.primaryUser}.shell = pkgs.fish;

    home-manager.users.${config.system.primaryUser} = {
      ${namespace}.cli.fish = enabled;
    };
  };
}
