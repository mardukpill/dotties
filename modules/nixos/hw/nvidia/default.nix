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
        "535"
        "default"
        "open"
      ];
      default = "default";
      description = "which version of nVidia drivers to use.";
    };
  };

  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
    };

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      package = mkIf (cfg.version == "535") (
        let
          rcu_patch = pkgs.fetchpatch {
            url = "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
            hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
          };
        in
        config.boot.kernelPackages.nvidiaPackages.mkDriver {
          version = "535.154.05";
          sha256_64bit = "sha256-fpUGXKprgt6SYRDxSCemGXLrEsIA6GOinp+0eGbqqJg=";
          sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
          openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
          settingsSha256 = "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
          persistencedSha256 = "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";
          patches = [ rcu_patch ];
        }
      );
      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
      # of just the bare essentials.
      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = (cfg.version == "open");

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";

        sync.enable = true;
        # this mode may lower power consumption
        # offload = {
        #	 enable = true;
        #	 enableOffloadCmd = true;
        # };
      };
    };
  };
}
