{ ... }:
{
  #  virtualisation.oci-containers.containers = {
  #    bazarr = {
  #      image = "lscr.io/linuxserver/bazarr:latest";
  #      ports = [
  #        "6767:6767"
  #      ];
  #      volumes = [
  #        "/home/thiago/bazarr:/config"
  #        "/home/thiago/data/tvseries:/data/tvshows"
  #        "/home/thiago/data/movies:/data/movies"
  #      ];
  #      environment = {
  #        PUID = "1000";
  #        GUID = "1000";
  #        TZ = "America/Sao_Paulo";
  #      };
  #    };
  #  };
  services.bazarr = {
    enable = true;
    user = "thiago";
    openFirewall = true;
  };
}
