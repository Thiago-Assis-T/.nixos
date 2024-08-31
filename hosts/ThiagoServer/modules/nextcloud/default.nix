{ config, pkgs, ... }: {
  networking.firewall.allowedTCPPorts = [ 80 443 5432 ];
  environment.etc."nextcloud-admin-pass".text = "4Hg428u$@";
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    enableImagemagick = true;
    #datadir = "/mnt/nextcloud-file";
    database.createLocally = true;
    maxUploadSize = "16G";
    configureRedis = true;
    hostName = "localhost";
    extraAppsEnable = true;
    autoUpdateApps.enable = true;
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        spreed richdocuments deck contacts calendar tasks notes;

    };
    config = {
      adminpassFile = "/etc/nextcloud-admin-pass";
      dbtype = "pgsql";
      adminuser = "admin";
    };
    settings = {
      default_phone_region = "BR";
      trusted_domains = [ "thiagoserver" ];
    };
  };
}
