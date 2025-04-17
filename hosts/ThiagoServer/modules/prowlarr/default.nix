{...}: {
  #virtualisation.oci-containers.containers = {
  #  prowlarr = {
  #    image = "lscr.io/linuxserver/prowlarr:latest";
  #    ports = [
  #      "9696:9696"
  #    ];
  #    volumes = [
  #      "/home/thiago/prowlarr:/config"
  #    ];
  #    environment = {
  #      PUID = "1000";
  #      GUID = "1000";
  #      TZ = "America/Sao_Paulo";
  #    };
  #  };
  #};
  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };
}
