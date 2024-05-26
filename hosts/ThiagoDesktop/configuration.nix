# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disk-config.nix
    ../modules/bootloader
    ../modules/tailscale
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  service.deluge = {
    enable = true;
    group = "multimedia";
    web = {
      enable = true;
      openFirewall = true;
    };
    declarative = true;
    dataDir = "/var/lib/deluge";
    openFirewall = true;
    config = {
      send_info = false;
      info_sent = 0;
      daemon_port = 58846;
      allow_remote = false;
      pre_allocate_storage = true;
      download_location = "/var/lib/deluge/downloads/";
      listen_ports = [
        6881
        6889
      ];
      random_port = true;
      listen_random_port = true;
      listem_use_sys_port = true;
      outgoing_ports = [
        0
        0
      ];
      random_outgoing_ports = true;
      copy_torrent_files = false;
      del_copy_torrent_file = false;
      torrentfiles_location = "/var/lib/deluge/downloads/.torrent/";
      plugins_location = "/var/lib/deluge/.config/deluge/plugins/";
      prioritize_first_last_pieces = false;
      sequential_download = false;
      dht = false;
      upnp = false;
      natpmp = false;
      utpex = false;
      lsd = false;
      enc_in_policy = 1;
      enc_out_policy = 1;
      enc_level = 2;
      max_connections_global = 200;
      max_upload_speed = "-1.0";
      max_download_speed = "-1.0";
      max_upload_slots_global = 4;
      max_half_open_connections = 50;
      max_connections_per_second = 20;
      ignore_limits_on_local_network = true;
      max_connections_per_torrent = -1;
      max_upload_slots_per_torrent = -1;
      max_upload_speed_per_torrent = -1;
      max_download_speed_per_torrent = -1;
      enabled_plugins = [ "Label" ];
      add_paused = false;
      max_active_seeding = 5;
      max_active_downloading = 3;
      max_active_limit = 8;
      dont_count_slow_torrents = false;
      queue_new_to_top = false;
      stop_seed_at_ratio = false;
      remove_seed_at_ratio = false;
      stop_seed_ratio = "2.0";
      share_ratio_limit = "2.0";
      seed_time_ratio_limit = "7.0";
      seed_time_limit = 180;
      auto_managed = true;
      move_completed = false;
      move_completed_path = "/var/lib/deluge/downloads/";
    };
    authFile = pkgs.writeTextFile {
      name = "deluge-auth";
      text = ''
        localclient:deluge:10
      '';
    };
  };
  networking.hostName = "ThiagoDesktop"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
    #   useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "br";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.thiago = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      #     firefox
      #     tree
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
