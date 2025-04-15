{_, ...}: {
  services.netdata = {
    enable = true;
    python.enable = true;
    enableAnalyticsReporting = true;
  };
}
