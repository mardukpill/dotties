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
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      "nvidia.NVreg_RegistryDwords=RMErrorEnable=0x0"
      "nvidia.NVreg_EnablePCIeGen3=1"
      "nvidia-drm.modeset=1"
    ];

    # boot.extraModprobeConfig = ''
    #   options nvidia NVreg_RegistryDwords="RmMsg=0x0" NVreg_DeviceFileUID=0 NVreg_DeviceFileGID=0 NVreg_DeviceFileMode=0666 NVreg_ResourceReserved=0x10000
    #   options nvidia NVreg_TemporaryFilePath=/var/tmp
    #   options nvidia-modeset modeset=1
    #   options nvidia NVreg_ReqEudyptBreakdown=1
    #   options nvidia NVreg_EnableStreamMemOPs=1
    #   options nvidia NVreg_EnableBacklightHandler=1
    #   options nvidia NVreg_InitializeSystemMemoryAllocations=1
    #   options nvidia NVreg_UsePageAttributeTable=1
    #   options nvidia NVreg_RegisterForACPIEvents=1
    #   options nvidia NVreg_MapRegistersEarly=1
    #   options nvidia NVreg_SurfaceWriteEviction=1
    #   options nvidia NVreg_EnableS0ixPowerManagement=0
    #   options nvidia NVreg_DynamicPowerManagement=0x02
    #   options nvidia-drm modeset=1
    # '';

    boot.blacklistedKernelModules = [ "nouveau" ];

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
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware = {
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          nvidia-vaapi-driver
        ];
      };
      nvidia = {
        modesetting.enable = true;
        nvidiaSettings = true;

        open = true;

        powerManagement.enable = true;
        powerManagement.finegrained = false;

        prime = {
          sync.enable = true;
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";

          # offload = {
          #   enable = true;
          #   enableOffloadCmd = true;
          # };
        };
      };
    };

    nixpkgs.config.cudaSupport = true;
  };
}
