{...}: {
  #virtualisation.oci-containers.containers = {
  #  radarr = {
  #    image = "lscr.io/linuxserver/radarr:latest";
  #    ports = [
  #      "7878:7878"
  #    ];
  #    volumes = [
  #      "/home/thiago/radarr:/config"
  #      "/home/thiago/data/movies:/movies"
  #      "/home/thiago/downloads:/downloads"
  #    ];
  #    environment = {
  #      PUID = "1000";
  #      GUID = "1000";
  #      TZ = "America/Sao_Paulo";
  #    };
  #  };
  #};

  services.radarr = {
    enable = true;
    openFirewall = true;
  };
}
