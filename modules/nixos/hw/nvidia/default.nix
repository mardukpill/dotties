{
  lib,
  pkgs,
  inputs,
  namespace,
  system,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption mkOption;
  cfg = config.${namespace}.hw.nvidia;
in
{
  options.${namespace}.hw.nvidia = {
    enable = mkEnableOption "nvidia hardware support.";
    version = mkOption {
      type = lib.types.enum [
        "default"
        "open"
      ];
      default = "default";
      description = "which version of nVidia drivers to use.";
    };
  };

  config = mkIf cfg.enable {
    boot.kernelParams = [
      "nvidia-drm.modeset=1"
      "pcie_aspm=off"
      "i915.enable_psr=0"
      "nvidia+drm.fbdev=1"
    ];

    boot.extraModprobeConfig = ''
      options nvidia-modeset modeset=1
      options nvidia-drm modeset=1
      options nvidia NVreg_PreserveVideoMemoryAllocations=1
    '';

    # options nvidia NVreg_DynamicPowerManagement=0x01

    boot.initrd.kernelModules = [
      "i915"
      "nvidia"
    ];

    environment.systemPackages = with pkgs; [
      nvfancontrol
      nvtopPackages.nvidia

      vulkan-tools
      vulkan-loader
    ];

    # Load nvidia driver for Xorg and Wayland
    services.xserver = {
      defaultDepth = 24;
      videoDrivers = [ "nvidia" ];
    };

    hardware = {
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          nvidia-vaapi-driver
          egl-wayland
        ];
      };
      nvidia = {
        dynamicBoost.enable = true;
        modesetting.enable = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.legacy_535;

        open = false;

        powerManagement.enable = true;
        powerManagement.finegrained = false;

        prime = {
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";

          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };
      };
    };

    nixpkgs.config.cudaSupport = true;
  };
}
