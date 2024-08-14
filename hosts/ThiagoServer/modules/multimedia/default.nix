{ pkgs, ... }: {

  users.groups.multimedia = { };
  users.users.thiago.extraGroups = [ "multimedia" ];
  users.users.multimedia = { isNormalUser = true; };

  environment.systemPackages = with pkgs; [ jellyfin-ffmpeg ];
  services = {
    jellyfin = {
      enable = true;
      group = "multimedia";
      user = "multimedia";
      openFirewall = true;
    };
    jellyseerr = {
      enable = true;
      openFirewall = true;
    };
    sonarr = {
      enable = true;
      group = "multimedia";
      user = "multimedia";
      openFirewall = true;
    };
    radarr = {
      enable = true;
      group = "multimedia";
      user = "multimedia";
      openFirewall = true;
    };
    bazarr = {
      enable = true;
      group = "multimedia";
      user = "multimedia";
      openFirewall = true;
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    deluge = {
      enable = true;
      dataDir = "/media/deluge";
      group = "multimedia";
      user = "multimedia";
      web = {
        enable = true;
        openFirewall = true;
      };
      declarative = false;
      openFirewall = true;
    };
  };
}
