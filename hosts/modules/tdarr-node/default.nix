{ ... }:
{
  virtualisation.oci-containers.containers = {
    tdarr-node = {
      image = "ghcr.io/haveagitgat/tdarr_node:latest";
      ports = [
        "8265:8265"
        "8266:8266"
      ];
      volumes = [
        "/home/thiago/data:/media"
        "/home/thiago/data/tdarr/configs:/app/configs"
        "/home/thiago/data/tdarr/logs:/app/logs"
        "/home/thiago/data/transcode_cache:/temp"

      ];
      devices = [
        "/dev/dri/renderD128:/dev/dri/renderD128"
      ];
      privileged = false;
      environment = {
        TZ = "America/Sao_Paulo";
        PUID = "1000";
        GUID = "1000";
        UMASK_SET = "002";
        serverIP = "192.168.8.233";
        serverPort = "8266";
        inContainer = "true";
        ffmpegVersion = "7";
        nodeName = "DesktopNode";
      };
    };
  };
}
