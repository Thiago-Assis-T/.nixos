{ pkgs, lib, ... }:
{
  virtualisation.oci-containers.containers = {
    foldingathome = {
      image = "lscr.io/linuxserver/foldingathome:latest";
      ports = [
        "7396:7396"
      ];
      volumes = [
        "/home/thiago/foldingathome:/config"
        "/dev/:/dev/"
      ];
      environment = {
        PUID = "1000";
        GUID = "1000";
        TZ = "America/Sao_Paulo";
        ACCOUNT_TOKEN = "YjY8TYjZZynf7Zyn3S6rP3S6HGu4-HGv9o6bn9o5e4U";
      };
    };
  };

  environment.systemPackages = with pkgs; [ clinfo ];
}
