{ ... }:
{
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "powersave";
  };
  services.thermald.enable = true;
  services = {
    power-profiles-daemon.enable = false;
    system76-scheduler = {
      enable = true;
      useStockConfig = true;
    };
  };
}
