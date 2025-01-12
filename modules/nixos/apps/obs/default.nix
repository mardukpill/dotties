{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.apps.obs;
in
{
  options.${namespace}.apps.obs = {
    enable = mkEnableOption "obs-studio.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ obs-studio ];

    boot = {
      extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
      ];
      extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
      '';

    };

  };
}
