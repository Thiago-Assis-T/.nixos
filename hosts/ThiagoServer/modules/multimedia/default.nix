{ pkgs, ... }:
{
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
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
