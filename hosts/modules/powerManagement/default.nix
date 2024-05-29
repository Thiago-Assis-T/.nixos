{ ... }:
{
  #environment.systemPackages = with pkgs; [ ];
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
  services = {
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
          energy_performance_preference = "powersave";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
          energy_performance_preference = "performance";
        };
      };
    };
    power-profiles-daemon.enable = false;
    system76-scheduler = {
      enable = false;
      useStockConfig = true;
    };
  };
}
