{ pkgs, ... }:
{
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
    ];
  };
  users.groups.multimedia = { };
  users.users.thiago.extraGroups = [ "multimedia" ];
  services = {
    jellyfin = {
      enable = true;
      group = "multimedia";
    };
    jellyseerr = {
      enable = true;
      openFirewall = true;
    };
    sonarr = {
      enable = true;
      group = "multimedia";
    };
    radarr = {
      enable = true;
      group = "multimedia";
    };
    bazarr = {
      enable = true;
      group = "multimedia";
    };
    prowlarr = {
      enable = true;
    };
    deluge = {
      enable = true;
      group = "multimedia";
      web = {
        enable = true;
        openFirewall = true;
      };
      declarative = true;
      dataDir = "/media/deluge";
      openFirewall = true;
      config = {
        send_info = false;
        info_sent = 0;
        daemon_port = 58846;
        allow_remote = false;
        pre_allocate_storage = true;
        download_location = "/media/downloads/";
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
        torrentfiles_location = "/media/downloads/.torrent/";
        plugins_location = "/media/deluge/.config/deluge/plugins/";
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
        move_completed_path = "/media/downloads/";
      };
      authFile = pkgs.writeTextFile {
        name = "deluge-auth";
        text = ''
          localclient:deluge:10
        '';
      };
    };
  };
}
