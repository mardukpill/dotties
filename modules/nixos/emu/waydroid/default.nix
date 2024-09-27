{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.emu.waydroid;
in
{
  options.${namespace}.emu.waydroid = {
    enable = mkEnableOption "Waydroid emulator.";
  };

  config = mkIf cfg.enable {
    virtualisation.waydroid = {
      enable = true;
    };
  };
}
