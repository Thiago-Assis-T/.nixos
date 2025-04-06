{ ... }:
{
  virtualisation.oci-containers.containers = {
    reverse-proxy = {
      #image = "jc21/nginx-proxy-manager:latest";
      image = "traefik:latest";
      cmd = [
        "--api.insecure=true"
        "--providers.docker"
      ];
      ports = [
        "80:80"
        "443:443"
        "81:8080"
      ];
      volumes = [
        #"/home/thiago/reverse-proxy:/data"
        "/var/run/podman/podman.sock:/var/run/docker.sock"
        #"/home/thiago/reverse-proxy/letsencrypt:/etc/letsencrypt"
      ];
      environment = {
        PUID = "1000";
        GUID = "1000";
      };
    };
  };

}
