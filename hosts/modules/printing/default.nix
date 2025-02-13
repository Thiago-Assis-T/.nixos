{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    webInterface = false;
    openFirewall = false;
    drivers = with pkgs; [
      gutenprint
      epsonscan2
      epson-escpr
      epson-escpr2
    ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
