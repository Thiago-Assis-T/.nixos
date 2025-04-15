{_, ...}: {
  services.smartd = {
    enable = true;
    devices = [
      {
        device = "/dev/sda";
      }
      {
        device = "/dev/sdb";
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
    };
    settings = {
      web = {
        listen.port = 8081;
      };
    };
  };
}
