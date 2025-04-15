{_, ...}: {
  powerManagement = {
    powertop.enable = true;
    enable = true;
  };
  services = {
    thermald.enable = true;
    tlp.enable = true;
    power-profiles-daemon.enable = false;
    system76-scheduler = {
      enable = false;
      useStockConfig = true;
    };
    scx = {
      enable = true;
      scheduler = "scx_bpfland";
      extraArgs = ["--cpufreq"];
    };
  };
}
