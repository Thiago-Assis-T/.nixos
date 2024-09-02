{ inputs, config, pkgs, lib,

... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
    ../modules/bootloader
    ../modules/tailscale
    ../modules/powerManagement
    ../modules/printing
    ./modules/multimedia
    ./modules/homepage-dashboard
    ./modules/nextcloud
  ];

  zramSwap.enable = true;

  systemd.services.NetworkManager-wait-online.enable = false;
  networking.hostName = "ThiagoServer"; # Define your hostname.
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.
  networking.useDHCP = lib.mkDefault true;
  networking.firewall.enable = true;
  networking.networkmanager.wifi.powersave = false;

  services.fwupd.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };

  users.users.thiago = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ htop ];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.autoUpgrade = {
    enable = true;
    dates = "02:00";
    flake = inputs.self.outPath;
    randomizedDelaySec = "45min";
    flags = [ "--update-input" "nixpkgs" "-L" ];
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
