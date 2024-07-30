{ inputs, config, pkgs, lib, ... }:
let
  dwl-source = inputs.dwl-src;
  cfg = config.programs.dwl;
  dwlPackage = import ./package.nix {
    inherit pkgs dwl-source;
    inherit (cfg) patches;
  };
in {
  options.programs.dwl = {
    enable = lib.mkEnableOption "dwl";
    package = lib.mkOption {
      type = lib.types.package;
      default = dwlPackage;
    };
    portalPackage = lib.mkOption {
      type = lib.types.package;
      default = pkgs.xdg-desktop-portal-wlr;
    };

    patches = lib.mkOption { default = [ ]; };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package pkgs.wmenu ];
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
