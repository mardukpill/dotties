{ pkgs, config, ... }:
{
  boot = {
    kernelParams = [
      "i915.force_probe=00:02.0"
    ];
    kernelPackages = pkgs.linuxPackages_6_6;
    plymouth = {
      enable = true;
    };
    loader = {
      grub = {
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "ntfs" ];
  };
}
