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
  services = {
    jellyfin = {
      enable = true;
      group = "multimedia";
    };
    jellyseerr = {
      enable = true;
      openFirewall = true;
    };
    sonarr = {
      enable = true;
      group = "multimedia";
    };
    radarr = {
      enable = true;
      group = "multimedia";
    };
    bazarr = {
      enable = true;
      group = "multimedia";
    };
    prowlarr = {
      enable = true;
    };
    deluge = {
      enable = true;
      group = "multimedia";
      web = {
        enable = true;
        openFirewall = true;
      };
      declarative = true;
      dataDir = "/media/deluge";
      openFirewall = true;
      config = {
        enabled_plugins = [ "Label" ];
      };
      authFile = pkgs.writeTextFile {
        name = "deluge-auth";
        text = ''
          localclient:deluge:10
        '';
      };
    };
  };
}
