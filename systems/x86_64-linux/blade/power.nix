{ ... }:
{
  services.tlp = {
    enable = true;
    settings = {
      # AC
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      RUNTIME_PM_ON_AC = "on";
      WIFI_PWR_ON_AC = "off";

      # BAT
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_MAX_PERF_ON_BAT = 40;
      CPU_MIN_PERF_ON_BAT = 1;
      CPU_BOOST_ON_BAT = 0;
      DISK_APM_LEVEL_ON_BAT = 128;
      PCIE_ASPM_ON_BAT = "powersave";
      RUNTIME_PM_ON_BAT = "on";

      # MISC
      USB_AUTOSUSPEND = 0;
      WOL_DISABLE = "Y";
    };
  };
}
