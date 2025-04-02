{ ... }:
{
  virtualisation.oci-containers.containers = {
    jellyseerr = {
      image = "ghcr.io/fallenbagel/jellyseerr:latest";
      ports = [
        "5055:5055"
      ];
      volumes = [
        "/home/thiago/jellyseerr:/config"
      ];
      environment = {
        PUID = "1000";
        GUID = "1000";
        TZ = "America/Sao_Paulo";
        PORT = "5055";
      };
    };
  };
}
