{ ... }: {
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
  services = {
    thermald.enable = true;
    tlp.enable = false;
    power-profiles-daemon.enable = false;
    system76-scheduler = {
      enable = true;
      useStockConfig = true;
    };
    scx = {
      enable = true;
      scheduler = "scx_lavd";
      extraArgs = [ "--autopilot" ]; 

    };
    auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "performance";
          energy_performance_preference = "performance";
          turbo = "always";
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
