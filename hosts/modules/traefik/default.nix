{ ... }:
{
  virtualisation.oci-containers.containers = {
    reverse-proxy = {
      image = "jc21/nginx-proxy-manager:latest";
      ports = [
        "80:80"
        "443:443"
        "81:81"
      ];
      volumes = [
        "/home/thiago/reverse-proxy:/data"
        "/home/thiago/reverse-proxy/letsencrypt:/etc/letsencrypt"
      ];
      environment = {
        PUID = "1000";
        GUID = "1000";
      };
    };
  };

}
