{ ... }:
{

  virtualisation.oci-containers.containers = {
    qbittorrent = {
      image = "lscr.io/linuxserver/qbittorrent:latest";
      ports = [
        "8080:8080"
        "6881:6881"
        "6881:6881/udp"
      ];
      volumes = [
        "/home/thiago/qbittorrent:/config"
        "/home/thiago/data/downloads:/downloads"
      ];
      environment = {
        PUID = "1000";
        GUID = "1000";
        TZ = "America/Sao_Paulo";
        WEBUI_PORT = "8080";
        TORRENTING_PORT = "6881";

      };

    };

  };

}
