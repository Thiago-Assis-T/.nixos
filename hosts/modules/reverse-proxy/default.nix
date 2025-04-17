{ ... }:
{
  virtualisation.oci-containers.containers = {
    reverse-proxy = {
      image = "jc21/nginx-proxy-manager:latest";
      cmd = [
      ];
      ports = [
        "80:80"
        "443:443"
        "81:81"
      ];
      volumes = [
        "/home/thiago/reverse-proxy:/data"
        "/var/run/podman/podman.sock:/var/run/docker.sock"
        "/home/thiago/reverse-proxy/letsencrypt:/etc/letsencrypt"
      ];
    };
  };

}
