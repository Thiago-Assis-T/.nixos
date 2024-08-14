{ ... }: {
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
  services = {
    thermald.enable = true;
    tlp.enable = true;
    power-profiles-daemon.enable = false;
    system76-scheduler = {
      enable = true;
      useStockConfig = true;
    };
    auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "performance";
          energy_performance_preference = "performance";
          turbo = "auto";
        };
        battery = {
          governor = "powersave";
          energy_performance_preference = "power";
          turbo = "never";
        };
        Settings = {
          epp_state_for_AC = "performance";
          epp_state_for_BAT = "power";
        };
      };
    };
  };
}
