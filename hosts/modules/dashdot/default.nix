{ ... }:
{
  virtualisation.oci-containers.containers = {
    dashdot = {
      image = "mauricenino/dashdot:latest";
      privileged = true;
      ports = [
        "80:3001"
      ];
      volumes = [
        "/:/mnt/host:ro"
      ];
    };
  };
}
