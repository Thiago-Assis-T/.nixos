{ ... }:
{
  virtualisation.oci-containers.containers = {
    tdarr-server = {
      image = "ghcr.io/haveagitgat/tdarr:latest";
      ports = [
        "8265:8265"
        "8266:8266"
      ];
      volumes = [
        "/home/thiago/data:/media"
        "/home/thiago/data/tdarr/server:/app/server"
        "/home/thiago/data/tdarr/configs:/app/configs"
        "/home/thiago/data/tdarr/logs:/app/logs"
        "/home/thiago/data/transcode_cache:/temp"

      ];
      extraOptions = [
        "--gpus=all"
        "--device=/dev/dri:/dev/dri"
      ];
      environment = {
        TZ = "America/Sao_Paulo";
        PUID = "1000";
        GUID = "1000";
        UMASK_SET = "002";
        serverIP = "0.0.0.0";
        serverPort = "8266";
        webUIPort = "8265";
        internalNode = "true";
        inContainer = "true";
        ffmpegVersion = "7";
        nodeName = "ServerNode";

      };

    };
  };
}
