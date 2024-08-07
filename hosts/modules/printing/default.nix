{ pkgs, ... }: {
  services.printing.enable = true;
  environment.systemPackages = with pkgs; [ system-config-printer ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
