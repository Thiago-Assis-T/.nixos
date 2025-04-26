{ ... }: {
  virtualisation.oci-containers.containers = {
    tdarr-server = {
      image = "ghcr.io/haveagitgat/tdarr:latest";
      ports = [
        "8265:8265"
        "8266:8266"
      ];
      volumes = [
        "/home/thiago/data:/media"
        "/home/thiago/tdarr/server:/app/server"
        "/home/thiago/tdarr/configs:/app/configs"
        "/home/thiago/tdarr/logs:/app/logs"
        "/home/thiago/tdarr/transcode_cache:/temp"
      ];
      extraOptions = [
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
        internalNode = "false";
        inContainer = "true";
        ffmpegVersion = "7";
        nodeName = "DesktopNode";
      };
    };
  };
}
