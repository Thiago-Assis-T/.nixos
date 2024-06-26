{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
    ../modules/bootloader
    ../modules/tailscale
    ../modules/powerManagement
    ../modules/stylix
    ./modules/multimedia
    ./modules/homepage-dashboard
  ];

  nix.settings.system-features = [
    "big-parallel"
    "gccarch-skylake"
  ];
  nixpkgs.config = {
    allowUnfree = true;
    localSystem = {
      system = "x86_64-linux";
      gcc.arch = "skylake";
      gcc.tune = "skylake";
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:01:0:0";
    };
  };
  networking.hostName = "ThiagoServer"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.useDHCP = lib.mkDefault true;
  networking.firewall.enable = true;
  networking.networkmanager.wifi.powersave = false;

  services.fwupd.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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

  system.stateVersion = "23.11"; # Did you read the comment?
}
