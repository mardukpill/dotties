{ config, ... }:
{
  boot = {
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
