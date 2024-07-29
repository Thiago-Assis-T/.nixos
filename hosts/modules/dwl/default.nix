{ config, pkgs, lib, dwl-source, ... }:
let
  cfg = config.programs.dwl;
  dwlPackage = import ./package.nix {
    inherit (cfg) patches;
    inherit dwl-source;
  };
in {
  options.programs.dwl = {
    enable = lib.mkEnableOption "dwl";
    package = lib.mkOption {
      type = lib.types.package;
      default = dwlPackage;
    };
    patches = lib.mkOption { default = [ ]; };
  };

  config =
    lib.mkIf cfg.enable { environment.systemPackages = with pkgs; [ dwl ]; };
}
