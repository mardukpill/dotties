{
  pkgs,
  system,
  namespace,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption enabled mkIf;

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
    };

    programs.bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        	then
        		shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        		exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
  };
}
