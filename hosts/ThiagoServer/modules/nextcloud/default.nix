{ config, pkgs, ... }: {
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    autoUpdateApps.enable = true;

    environment.etc."nextcloud-admin-pass".text = "nextcloudTest4Hg428u$@";

    configureRedis = true;
    maxUploadSize = "16G";

    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        news contacts calendar tasks;
    };
    extraAppsEnable = true;
    config = {
      dbtype = "pgsql";
      adminpassFile = "/etc/nextcloud-admin-pass";
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];

}
