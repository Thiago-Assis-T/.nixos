{
  inputs,
  config,
  pkgs,
  lib,

  ...
}:

{
  imports = [
    inputs.stylix.nixosModules.stylix
    ./hardware-configuration.nix
    ../modules/bootloader
    ../modules/stylix
    ../modules/docs
    ../modules/smartmon
    ../modules/samba
    ../modules/podman
    ../modules/homarr
    ../modules/qbittorrent
    ../modules/prowlarr
    ../modules/sonarr
    ../modules/radarr
    ../modules/bazarr
    ../modules/jellyseerr
    ../modules/jellyfin
    ../modules/tdarr-server
    ../modules/snowflake-proxy
    ../modules/reverse-proxy
    #../modules/noXLibs
  ];

  powerManagement = {
    enable = false;
    powertop.enable = false;
  };
  services = {
    thermald.enable = true;
    tlp.enable = true;
    scx = {
      enable = true;
      scheduler = "scx_lavd";
      extraArgs = [ "--autopilot" ];
    };
  };
  boot.plymouth.enable = lib.mkForce false;
  security.sudo-rs.enable = true;
  environment.systemPackages = with pkgs; [
    uutils-coreutils-noprefix
  ];

  services.power-profiles-daemon.enable = lib.mkForce false;
  zramSwap.enable = true;

  systemd.services.NetworkManager-wait-online.enable = false;
  networking.hostName = "ThiagoServer"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.networkmanager.wifi.backend = "iwd";
  networking.networkmanager.plugins = lib.mkForce [ ];
  networking.useDHCP = lib.mkDefault true;
  networking.firewall.enable = true;
  networking.networkmanager.wifi.powersave = false;

  services.tailscale = {
    enable = false;
  };

  services.fwupd.enable = true;

  services.fstrim.enable = true;
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

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
    packages = with pkgs; [
      htop
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.autoUpgrade = {
    enable = true;
    dates = "02:00";
    flake = inputs.self.outPath;
    randomizedDelaySec = "45min";
    flags = [
      "--update-input"
      "nixpkgs"
      "--no-write-lock-file"
      "-L"
    ];
  };

  system.stateVersion = "23.11";
}
