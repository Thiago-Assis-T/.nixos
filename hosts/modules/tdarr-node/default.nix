{ ... }: {
  virtualisation.oci-containers.containers = {
    tdarr = {
      image = "ghcr.io/haveagitgat/tdarr_node:latest";
      ports = [
        "8265:8265"
        "8266:8266"
      ];
      volumes = [
        "/home/thiago/data:/media"
        "/home/thiago/tdarr/configs:/app/configs"
        "/home/thiago/tdarr/logs:/app/logs"
        "/home/thiago/tdarr/transcode_cache:/temp"
      ];
      devices = [
        "/dev/dri/:/dev/dri/"
        "/dev/kfd:/dev/kfd"
      ];
      environment = {
        TZ = "America/Sao_Paulo";
        PUID = "1000";
        GUID = "1000";
        UMASK_SET = "002";
        #serverIP = "192.168.1.183";
        serverIP = "thiagohome.com";
        serverPort = "8266";
        inContainer = "true";
        ffmpegVersion = "7";
        nodeName = "DesktopNode";
      };
    };
  };
}
