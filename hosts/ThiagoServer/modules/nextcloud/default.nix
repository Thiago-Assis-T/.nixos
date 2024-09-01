{ config, pkgs, ... }: {
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  environment.etc."nextcloud-admin-pass".text = "4Hg428u$@";
  virtualisation.oci-containers = {
    backend = "podman";
    containers.collabora = {
      image = "collabora/code:latest";
      ports = [ "9980:9980" ];
      environment = {
        domain = "cloud.thiagohome.com";
        extra_params = "--o:ssl.enable=false --o:ssl.termination=false";
      };
      extraOptions = [ "--cap-add" "MKNOD" ];
    };
  };
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    enableImagemagick = true;
    #datadir = "/mnt/nextcloud-file";
    database.createLocally = true;
    maxUploadSize = "16G";
    configureRedis = true;
    hostName = "cloud.thiagohome.com";
    extraAppsEnable = true;
    autoUpdateApps.enable = true;
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        spreed richdocuments deck contacts calendar tasks notes;
      skyprint = pkgs.fetchNextcloudApp {
        sha256 = "sha256-axgTj8VUbVqtJj0TFXX/UGtVZ8+KLYsQPEQEbzjiUhI=";
        url =
          "https://github.com/CGessinger/nextcloud-skyprint/releases/download/v0.1.6/skyprint.tar.gz";
        license = "gpl3";
      };
    };
    config = {
      adminpassFile = "/etc/nextcloud-admin-pass";
      dbtype = "pgsql";
      adminuser = "admin";
    };
    settings = {
      default_phone_region = "BR";
      trusted_domains =
        [ "cloud.thiagoserver" "office.thiagoserver" "thiagoserver" ];
    };
  };
  services.nginx.virtualHosts."cloud.thiagohome.com" = {
    locations = {
      "/".proxyWebsockets = true;
      # uh, equals what?
      "~ ^/nextcloud/(?:index|remote|public|cron|core/ajax/update|status|ocs/v[12]|updater/.+|oc[ms]-provider/.+|.+/richdocumentscode/proxy).php(?:$|/)" =
        { };
    };
  };
  services.nginx.virtualHosts."office.thiagohome.com" = {
    locations = {
      # static files
      "^~ /loleaflet" = {
        proxyPass = "http://localhost:9980";
        extraConfig = ''
          proxy_set_header Host $host;
        '';
      };
      # WOPI discovery URL
      "^~ /hosting/discovery" = {
        proxyPass = "http://localhost:9980";
        extraConfig = ''
          proxy_set_header Host $host;
        '';
      };

      # Capabilities
      "^~ /hosting/capabilities" = {
        proxyPass = "http://localhost:9980";
        extraConfig = ''
          proxy_set_header Host $host;
        '';
      };

      # download, presentation, image upload and websocket
      "~ ^/lool" = {
        proxyPass = "http://localhost:9980";
        extraConfig = ''
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "Upgrade";
          proxy_set_header Host $host;
          proxy_read_timeout 36000s;
        '';
      };

      # Admin Console websocket
      "^~ /lool/adminws" = {
        proxyPass = "http://localhost:9980";
        extraConfig = ''
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "Upgrade";
          proxy_set_header Host $host;
          proxy_read_timeout 36000s;
        '';
      };
    };
  };
}
