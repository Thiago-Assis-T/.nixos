{ config, pkgs, ... }:

{
  config.virtualisation.oci-containers.containers = {
    homarr = {
      image = "ghcr.io/homarr-labs/homarr:latest";
      ports = [ "7575:7575" ];
      volumes = [
        "/var/run/podman/podman.sock:/var/run/docker.sock"
        "/home/thiago/homarr:/appdata"

      ];
      environment = {
        SECRET_ENCRYPTION_KEY = "563bb250e2ab8786181e3a35717499a801c0fad74e9ce3df7dca92ecabfbbf84";

      };
    };
  };
}
