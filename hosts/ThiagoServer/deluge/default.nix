{ ... }:
{
  services.deluge = {
    enable = true;
    dataDir = "/home/thiago/Downloads/";
    web = {
      enable = true;
      openFirewall = true;
    };
  };
}
