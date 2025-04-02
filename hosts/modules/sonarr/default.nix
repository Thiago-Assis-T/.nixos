{ ... }:
{
  virtualisation.oci-containers.containers = {
    sonarr = {
      image = "lscr.io/linuxserver/sonarr:latest";
      ports = [
        "8989:8989"
      ];
      volumes = [
        "/home/thiago/sonarr:/config"
        "/home/thiago/data/tvseries:/tv"
        "/home/thiago/data/downloads:/downloads"
      ];
      environment = {
        PUID = "1000";
        GUID = "1000";
        TZ = "America/Sao_Paulo";
      };
    };
  };
}
