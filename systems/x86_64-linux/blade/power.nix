{ ... }:
{
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      RUNTIME_PM_ON_AC = "on";
      WIFI_PWR_ON_AC = "off";

      USB_AUTOSUSPEND = "0";
    };
  };
}
