{ pkgs, ... }:
{
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime
    ];
  };
  users.groups.multimedia = { };
  users.users.thiago.extraGroups = [ "multimedia" ];
  users.users.multimedia = {
    isNormalUser = true;
  };

  environment.systemPackages = with pkgs; [ jellyfin-ffmpeg ];
  services = {
    jellyfin = {
      enable = true;
      group = "multimedia";
      user = "multimedia";
    };
    jellyseerr = {
      enable = true;
      openFirewall = true;
    };
    sonarr = {
      enable = true;
      group = "multimedia";
      user = "multimedia";
    };
    radarr = {
      enable = true;
      group = "multimedia";
      user = "multimedia";
    };
    bazarr = {
      enable = true;
      group = "multimedia";
      user = "multimedia";
      openFirewall = true;
    };
    prowlarr = {
      enable = true;
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
