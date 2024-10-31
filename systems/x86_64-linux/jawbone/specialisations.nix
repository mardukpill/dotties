{
  pkgs,
  lib,
  namespace,
  ...
}:
let
  inherit (lib.${namespace}) disabled enabled;
  inherit (lib) mkForce;

  gpuPci = [
    "10de:2430"
    "10de:228b"
  ];
in
{
  specialisation = {
    integrated = {
      configuration = {
        dotties.hw.nvidia = mkForce disabled;

        hardware.nvidia = {
          open = false;
          modesetting = disabled;
          package = null;
        };

        system.nixos.tags = [ "integrated" ];

        systemd.tmpfiles.rules = [
          "f /dev/shm/looking-glass 0660 mike kvm 32M"
        ];

        environment.systemPackages = with pkgs; [
          virt-manager
          looking-glass-client
          pciutils
          swtpm
        ];

        virtualisation.libvirtd = {
          enable = true;
          qemu = {
            ovmf.enable = true;
            package = pkgs.qemu_kvm;
            swtpm = enabled;
          };
        };

        dotties.user.extraGroups = [
          "libvirtd"
          "kvm"
        ];

        boot = {
          kernelModules = [ "kvm-intel" ];
          # kernelPackages = [ "kvmfr" ];
          kernel.sysctl."vm.max_map_count" = mkForce 1048576;

          blacklistedKernelModules = [
            "nvidia"
            "nouveau"
          ];

          initrd.kernelModules = [
            "vfio_pci"
            "vfio"
            "vfio_iommu_type1"
            # "vfio_virqfd"

          ];

          kernelParams =
            [
              "intel_iommu=on"
              "iommu=pt"
              "pcie_aspm=off"
              "isolcpus=0-5,12-17"
              "vm.nr_hugepages=8192" # should be ~16G
              "vm.hugetlb_shm_group=48"
            ]
            ++
            # isolate the GPU
            [ ("vfio-pci.ids=" + lib.concatStringsSep "," gpuPci) ];
        };
      };
    };
  };
}
