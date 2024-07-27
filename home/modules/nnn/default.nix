{ config, lib, pkgs, ... }:

let cfg = config.programs.my-nnn;
in {
  options.programs.my-nnn = {
    enable = lib.mkEnableOption (lib.mdDoc "my-nnn");
  };

  config = lib.mkIf cfg.enable {
    programs.nnn = {
      enable = true;
      extraPackages = with pkgs; [ ffmpegthumbnailer mediainfo sxiv ];
    };
  };
}
