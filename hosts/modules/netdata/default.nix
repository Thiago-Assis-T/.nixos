{pkgs, ...}: {
  services.netdata = {
    enable = true;
    #package = with pkgs;
    #  netdata.override
    #  {
    #    withCups = true;
    #    withCloudUi = true;
    #    withCloud = true;
    #    withEbpf = true;
    #    withNdsudo = true;
    #  };
    python.enable = true;
    enableAnalyticsReporting = true;
    config = {
      global = {
        "memory mode" = "ram";
        "debug log" = "none";
        "access log" = "none";
        "error log" = "syslog";
      };
      db = {
        "mode" = "dbengine";
      };
    };
    #extraNdsudoPackages = with pkgs; [smartmontools nvme-cli];
  };
  networking.firewall.allowedTCPPorts = [19999];
}
