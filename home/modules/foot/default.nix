{ config, lib, ... }:

let
  cfg = config.programs.my-foot;
in
{
  options.programs.my-foot = {
    enable = lib.mkEnableOption (lib.mdDoc "my-foot");
  };

  config = lib.mkIf cfg.enable {
    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          dpi-aware = "yes";
        };
        mouse = {
          hide-when-typing = "yes";
        };
      };
    };
  };
}
