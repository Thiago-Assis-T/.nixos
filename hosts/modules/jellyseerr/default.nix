{ pkgs, ... }:
{
  services.jellyseerr = {
    enable = true;
    openFirewall = true;
  };
}
