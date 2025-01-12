{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.utility.swappy;
in
{
  options.${namespace}.utility.swappy = {
    enable = mkEnableOption "swappy.";
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        swappy
      ];

      sessionVariables = {
        GRIMBLAST_EDITOR = "uwsm app -- swappy --file";
      };
    };
    xdg.configFile.swappy = {
      source = ./swappy;
      recursive = true;
    };
  };
}
