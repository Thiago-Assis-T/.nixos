{ config, pkgs, lib, ... }:
let
  cfg = config.programs.dwl;
  scripts = {
    dwlStart = pkgs.writeShellScriptBin "dwlStart" ''
      # Starts the wallpaper daemon
      exec ${pkgs.wbg}/bin/wbg /home/thiago/Pictures/wallpaper &
      # Starts the notification
      exec ${pkgs.swaynotificationcenter}/bin/swaync &
      # Wlsunset for the screen light
      exec ${pkgs.wlsunset}/bin/wlsunset -l 22.8 -L 43.1 &

      exec ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
    '';
    grabMedia = pkgs.writeShellScriptBin "grabMedia" ''
      # Get the current status of playerctl
      status=$(${pkgs.playerctl}/bin/playerctl status)

      # Check if the status is "Playing"
      if [ "$status" = "Playing" ]; then
      # Fetch metadata using playerctl
      artist=$(${pkgs.playerctl}/bin/playerctl metadata artist)
      title=$(${pkgs.playerctl}/bin/playerctl metadata title)

      # Print the song and artist
      echo " [ $title - $artist] "
      else
      echo " "
      fi
    '';
  };
in {
  options.programs.dwl = {
    enable = lib.mkEnableOption "dwl";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.dwl;
    };
    portalPackage = lib.mkOption {
      type = lib.types.package;
      default = pkgs.xdg-desktop-portal-wlr;
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
      pkgs.wmenu
      pkgs.wbg
      pkgs.grim
      pkgs.slurp
      pkgs.wl-clipboard
      pkgs.wlogout
      pkgs.wlsunset
      pkgs.swaynotificationcenter
      pkgs.playerctl
      pkgs.polkit_gnome
      scripts.grabMedia
      scripts.dwlStart
    ];
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-media-tags-plugin
        thunar-archive-plugin
        thunar-volman
      ];
    };
    services.xserver.desktopManager.runXdgAutostartIfNone = true;
    programs.dconf.enable = true;
    xdg = {
      mime.enable = true;
      autostart.enable = true;
      portal = {
        enable = true;
        wlr.enable = true;
        xdgOpenUsePortal = true;
        configPackages = lib.mkDefault [ cfg.package ];
        extraPortals = [ cfg.portalPackage ];
      };
    };
    services.displayManager.sessionPackages = [ cfg.package ];
  };
}
