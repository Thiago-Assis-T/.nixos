{ config, pkgs, lib, ... }:
let

  cfg = config.programs.gpu;

in {

  options.programs.gpu = {
    enable = lib.mkEnableOption "gpu";
    amd = lib.mkOption "amd";
    intel = lib.mkoption "intel";
    config = lib.mkIf cfg.enable {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
      amd = lib.mkIf cfg.amd.enable {
        hardware.graphics = {
          extraPackages = with pkgs; [ amdvlk rocmPackages.clr.icd ];
          extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
        };
        environment.systemPackages = with pkgs; [ lact ];
        systemd.packages = with pkgs; [ lact ];
        systemd.services.lactd.wantedBy = [ "multi-user.target" ];
      };
      intel = lib.mkIf cfg.intel.enable {
        hardware.graphics = {
          extraPackages = with pkgs; [
            intel-media-driver
            intel-vaapi-driver
            vaapiVdpau
            libvdpau-va-gl
            intel-compute-runtime
          ];
        };
      };
    };
  };
}
