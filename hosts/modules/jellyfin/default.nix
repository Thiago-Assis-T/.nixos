{ ... }:
{
  virtualisation.oci-containers.containers = {
    jellyfin = {
      image = "lscr.io/linuxserver/jellyfin:latest";
      ports = [
        "8096:8096"
        "8920:8920"
        "7359:7359/udp"
        "1900:1900/udp"
      ];
      volumes = [
        "/home/thiago/jellyfin:/config"
        "/home/thiago/data/tvseries:/data/tvshows"
        "/home/thiago/data/movies:/data/movies"
      ];
      environment = {
        PUID = "1000";
        GUID = "1000";
        TZ = "America/Sao_Paulo";
      };
      extraOptions = [
        "--device=/dev/dri/:/dev/dri/"
      ];
    };
  };
}
