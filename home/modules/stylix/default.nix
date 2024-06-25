{ config, lib, ... }:

let
  cfg = config.programs.my-shell;
in

{

  options.programs.my-style = {
    enable = lib.mkEnableOption (lib.mdDoc "my-style");
  };
  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      image = ../../../wallpapers/spaceBattle.png;
    };
  };
}
