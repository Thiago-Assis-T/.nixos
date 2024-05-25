{ pkgs, ... }:
{
  users.groups.multimedia = { };
  users.users.thiago.extraGroups = [ "multimedia" ];
  services = {
    jellyfin = {
      enable = true;
      group = "multimedia";
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
      group = "multimedia";
    };
    deluge = {
      enable = true;
      group = "multimedia";
      web.enable = true;
      dataDir = "/home/thiago/media/torrent";
      declarative = true;
      config = {
        enabled_plugins = [ "Label" ];
      };
      authFile = pkgs.writeTextFile {
        name = "deluge-auth";
        text = ''
          localclient::10
        '';
      };
    };
  };
}
