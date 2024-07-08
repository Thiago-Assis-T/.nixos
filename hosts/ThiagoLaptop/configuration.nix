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
    ../modules/stylix
  ];

  zramSwap.enable = true;

  networking.hostName = "ThiagoLaptop"; # Define your hostname.
  programs.nm-applet.enable = true;

  systemd.services.NetworkManager-wait-online.enable = false;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  programs.dconf.enable = true;

  xdg = {
    autostart.enable = true;
    sounds.enable = true;
    portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      configPackages = with pkgs; [ xdg-desktop-portal-hyprland ];
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-wlr
      ];
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

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime
    ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = 1;
  networking.networkmanager = {
    enable = true;
    wifi = {
      powersave = true;
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.seatd.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
    #useXkbConfig = true; # use xkb.options in tty.
  };
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.thiago = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = [ ];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  networking.firewall.enable = true;

  system.autoUpgrade = {
    enable = true;
    dates = "02:00";
    flake = inputs.self.outPath;
    randomizedDelaySec = "45min";
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"
    ];
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
