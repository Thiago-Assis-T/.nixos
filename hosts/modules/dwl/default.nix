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
    environment.systemPackages = [ cfg.package ];
    services.displayManager.sessionPackages = [ cfg.package ];
    xdg.portal = {
      enable = true;
      extraPortals = [ cfg.portalPackage ];
      configPackages = lib.mkDefault [ cfg.package ];
    };
  };
}
