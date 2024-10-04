{ pkgs, ... }: {
  services.system-config-printer.enable = true;
  programs.system-config-printer.enable = true;
  hardware.sane.enable = true;
  users.users.thiago.extraGroups = [ "scanner" "lp" ];
  environment.systemPackages =with pkgs; [
    simple-scan
  ];
  services.printing = {
    enable = true;
    webInterface = false;
    openFirewall = false;
    drivers = with pkgs; [ gutenprint epsonscan2 epson-escpr epson-escpr2 ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
