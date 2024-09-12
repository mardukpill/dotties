{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption enabled mkIf;
  inherit (lib.${namespace}) defineCssColors;

  palette = config.colorScheme.palette;

  cfg = config.${namespace}.utility.wlogout;
in
{
  options.${namespace}.utility.wlogout = {
    enable = mkEnableOption "wlogout.";
  };

  config = mkIf cfg.enable {
    programs.wlogout = {
      enable = true;
      layout = [
        {
          label = "lock";
          action = "hyprlock --immediate";
          text = "LOCK";
        }
        {
          label = "shutdown";
          action = "shutdown -h now";
          text = "POWEROFF";
        }
        {
          label = "reboot";
          action = "reboot";
          text = "REBOOT";
        }
      ];
      style = defineCssColors palette + builtins.readFile ./style.css;
    };
  };
}
