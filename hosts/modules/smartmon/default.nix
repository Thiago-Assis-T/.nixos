{_}: {
  services.smartd.enable = true;
  services.scrutiny = {
    enable = true;
    openFirewall = true;
    settings.web.listen.port = 8081;
    influxdb.enable = true;
    collector.enable = true;
  };
}
