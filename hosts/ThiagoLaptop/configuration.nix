# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disk-config.nix
    ../modules/bootloader
    ../modules/tailscale
    ../modules/powerManagement
    ../modules/loginManager
    ../modules/dwl
    ../modules/printing
  ];

  programs.dwl = {
    enable = true;
    package = pkgs.dwlLaptop;
  };
  environment.systemPackages = with pkgs; [ slstatusLaptop ];

  zramSwap.enable = true;

  programs.light.enable = true;
  networking.hostName = "ThiagoLaptop"; # Define your hostname.

  systemd.services.NetworkManager-wait-online.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  programs.dconf.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = 1;
  networking.networkmanager = {
    enable = true;
    wifi = { powersave = true; };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";
  fonts = {
    fonts = with pkgs; [ nerdfonts ];
    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = { monospace = [ "JetBrainsMono" ]; };
    };
  };
  fonts.fontDir.enable = true;
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.thiago = {
    isNormalUser = true;
    extraGroups = [ "video" "wheel" ]; # Enable ‘sudo’ for the user.
    packages = [ ];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  networking.firewall.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
