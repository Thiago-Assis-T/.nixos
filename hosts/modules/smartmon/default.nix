{pkgs, ...}: {
  environment.systemPackages = with pkgs; [smartmontools];
  services.smartd = {
    enable = true;
    autodetect = true;
    devices = [
      {
        device = "/dev/sda";
      }
      {
        device = "/dev/sdb";
      }
      {
        device = "/dev/sdc";
      }
      {
        device = "/dev/sdd";
      }
    ];
  };
  services.scrutiny = {
    enable = true;
    openFirewall = true;
    influxdb.enable = true;
    collector = {
      enable = true;
      schedule = "*:0/5";
      settings = {
      };
    };
    settings = {
      web = {
        listen.port = 8081;
      };
    };
  };
}
