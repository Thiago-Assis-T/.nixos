{ config, lib, ... }:

let
  cfg = config.programs.my-swaync;
in
{
  options.programs.my-swaync = {
    enable = lib.mkEnableOption (lib.mdDoc "my-swaync");
  };

  config = lib.mkIf cfg.enable {
    services.swaync = {
      enable = true;
      settings = { };
    };
  };
}
