{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.kdePackages.skanlite
    pkgs.kdePackages.skanpage
  ];
  services.udev.packages = [ pkgs.utsushi ];
  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.utsushi
      pkgs.epkowa
    ];
  };
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
