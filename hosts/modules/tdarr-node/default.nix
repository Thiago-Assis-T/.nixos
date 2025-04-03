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
        #"/home/thiago/data:/media"
        "/home/thiago/tdarr/configs:/app/configs"
        "/home/thiago/tdarr/logs:/app/logs"
        "/home/thiago/data/transcode_cache:/temp"

      ];
      extraOptions = [ "--device=/dev/dri:/dev/dri" ];
      environment = {
        TZ = "America/Sao_Paulo";
        PUID = "1000";
        GUID = "1000";
        UMASK_SET = "002";
        serverIP = "100.73.62.17";
        serverPort = "8266";
        inContainer = "true";
        ffmpegVersion = "7";
        nodeName = "DesktopNode";

      };

    };
  };
}
