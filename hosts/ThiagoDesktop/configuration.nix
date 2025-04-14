# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ../modules/bootloader
    ../modules/powerManagement
    ../modules/smartmon
    ../modules/printing
    ../modules/hyprland
    ../modules/stylix
    ../modules/samba-client
    ./hardware-configuration.nix
    inputs.stylix.nixosModules.stylix
    ../modules/tdarr-node
    ../modules/snowflake-proxy
    ../modules/foldingAtHome
  ];
  services.gvfs.enable = true;

  services.openssh.enable = true;

  services.tailscale = {
    enable = false;
    extraUpFlags = [
      "--accept-routes"
    ];
  };

  security.sudo-rs.enable = true;

  hardware = {

    amdgpu = {
      opencl.enable = true;
      initrd.enable = true;
      amdvlk = {
        enable = true;
        supportExperimental.enable = true;
        support32Bit.enable = true;
      };
    };
    graphics = {
      enable32Bit = true;
      # See also seat-configuration.nix for other OpenGL settings

      extraPackages = with pkgs; [
        # VA-API and VDPAU
        vaapiVdpau

        # AMD ROCm OpenCL runtime
        rocmPackages.clr
        rocmPackages.clr.icd

        # AMDVLK drivers can be used in addition to the Mesa RADV drivers.
        amdvlk
      ];
      extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    };
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        renice = 10;
      };
      # Warning: GPU optimisations have the potential to damage hardware
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        amd_performance_level = "high";
      };

      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };

  };
  programs.java.enable = true;
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    protontricks.enable = true;
  };
  environment.systemPackages = with pkgs; [
    heroic
    lutris
  ];

  services.fwupd.enable = true;
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    hostPlatform = {
      system = "x86_64-linux";
    };
  };
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      randomizedDelaySec = "25min";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
  zramSwap.enable = true;

  services.fstrim.enable = true;
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  networking.hostName = "ThiagoDesktop"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  systemd.services.NetworkManager-wait-online.enable = false;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
    #   useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "abnt2";
  };

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.thiago = {
    description = "Thiago";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "gamemode"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      kdePackages.isoimagewriter
      uutils-coreutils-noprefix
      nvtopPackages.full
    ];
  };

  networking.firewall.enable = true;
  system.stateVersion = "24.11"; # Did you read the comment?

}
