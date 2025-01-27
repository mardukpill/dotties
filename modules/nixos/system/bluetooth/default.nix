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
  cfg = config.${namespace}.system.bluetooth;
in
{
  options.${namespace}.system.bluetooth = {
    enable = mkEnableOption "bluetooth .";
  };
  config = mkIf cfg.enable {
    hardware.bluetooth = enabled;
    services.blueman = enabled;

    environment.systemPackages = with pkgs; [
      bluetuith
    ];
  };
}
