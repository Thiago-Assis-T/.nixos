{ ... }:
{
  services.deluge = {
    enable = true;
    web = {
      enable = true;
      openFirewall = true;
    };
    declarative = true;
    openFirewall = true;
    authFile = /home/thiago/deluge-auth;
    config = {
      download_location = "/thiago/Downloads";
      allow_remote = true;
      daemon_port = 58846;
      listen_ports = [
        6881
        6889
      ];
    };
  };
}
