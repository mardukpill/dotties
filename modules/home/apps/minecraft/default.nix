{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.${namespace}.apps.minecraft;
in
{
  options.${namespace}.apps.minecraft = {
    enable = mkEnableOption "minecraft.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lunar-client
      glfw3-minecraft
    ];
  };
}
