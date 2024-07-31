# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, pkgs, lib, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disk-config.nix
    ../modules/bootloader
    ../modules/tailscale
    ../modules/powerManagement
    ../modules/stylix
    ../modules/loginManager
    ../modules/dwl
  ];
  programs.dwl = {
    enable = true;
    patches = [
      ../modules/dwl/patches/ipc.patch
      ../modules/dwl/patches/focus-tagset-output.patch
      ../modules/dwl/patches/autostart.patch
    ];
  };

  zramSwap.enable = true;
  services.openssh.enable = true;

  programs.nm-applet.enable = true;

  services.xserver.excludePackages = with pkgs; [ xterm ];
  services.xserver.displayManager.lightdm.enable = false;

  systemd.services.NetworkManager-wait-online.enable = false;

  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        renice = 10;
        desiredgov = "performance";
        igpu_desiredgov = "performance";
        softrealtime = "on";
      };

      # Warning: GPU optimisations have the potential to damage hardware
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 1;
        amd_performance_level = "high";
      };

      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    extest.enable = true;
  };

  nixpkgs.config = { allowUnfree = true; };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ amdvlk rocmPackages.clr.icd ];
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
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

  powerManagement.powertop.enable = lib.mkForce false;

  services.fwupd.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.sessionVariables.NIXOS_OZONE_WL = 1;
  networking.hostName = "ThiagoDesktop"; # Define your hostname.
  networking.networkmanager = {
    enable = true;
    wifi = { powersave = false; };
  };
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_CA.UTF-8";
  fonts.fontconfig.enable = true;
  fonts.fontconfig.antialias = true;
  fonts.fontDir.enable = true;
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

  system.autoUpgrade = {
    enable = true;
    dates = "02:00";
    flake = inputs.self.outPath;
    randomizedDelaySec = "45min";
    flags = [ "--update-input" "nixpkgs" "-L" ];
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
