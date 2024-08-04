{ config, pkgs, lib, ... }:
let cfg = config.programs.dwl;
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
    ];
    services.xserver.desktopManager.runXdgAutostartIfNone = true;
    programs.dconf.enable = true;
    xdg = {
      autostart.enable = true;
      sounds.enable = true;
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
