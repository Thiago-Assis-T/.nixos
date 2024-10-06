{ config, lib, ... }:
let
  cfg = config.programs.my-git;

in
{

  options.programs.my-zathura = {
    enable = lib.mkEnableOption (lib.mdDoc "my-zathura");
  };
  config = lib.mkIf cfg.enable {
    programs.zathura = {
      enable = true;
      #extraConfig = builtins.readFile ./zathurarc;
    };

  };
}
