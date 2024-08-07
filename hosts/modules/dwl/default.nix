{ config, pkgs, lib, ... }:
let
  cfg = config.programs.dwl;
  scripts = {
    dwlStart = pkgs.writeShellScriptBin "dwlStart"
      "	# Starts the wallpaper daemon\n	exec wbg /home/thiago/Pictures/wallpaper &\n\n	# Starts the notification\n	exec swaync &\n\n	# Wlsunset for the screen light\n	exec wlsunset -l 22.8 -L 43.1 &\n	 \n";
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
      pkgs.slstatus
      pkgs.wlogout
      pkgs.playerctl
      scripts.grabMedia
      scripts.dwlStart
    ];
    services.xserver.desktopManager.runXdgAutostartIfNone = true;
    programs.dconf.enable = true;
    xdg = {
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
