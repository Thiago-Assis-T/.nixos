# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, lib, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disk-config.nix
    ../modules/bootloader
    ../modules/tailscale
    ../modules/powerManagement
    ../modules/stylix
  ];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    extest.enable = true;
  };

  #nixpkgs.hostPlatform = lib.systems.examples.musl64;

  programs.dconf.enable = true;
  xdg = {
    autostart.enable = true;
    sounds.enable = true;
    portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      configPackages = with pkgs; [ xdg-desktop-portal-hyprland ];
      extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.displayManager = {
    defaultSession = "hyprland";
    sddm = {
      wayland.enable = true;
      enable = true;
    };
  };
  nixpkgs.config = {
    allowUnfree = true;
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
      rocmPackages.clr.icd
    ];
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.seatd.enable = true;

  powerManagement.powertop.enable = lib.mkForce false;

  services.fwupd.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = 1;
  networking.hostName = "ThiagoDesktop"; # Define your hostname.
  networking.networkmanager = {
    enable = true;
    wifi = {
      macAddress = "random";
    };
  };
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_CA.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };
  services.xserver.enable = true;
  services.xserver.xkb.layout = "br";

  users.users.thiago = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = [ ];
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
