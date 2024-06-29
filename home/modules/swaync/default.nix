{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.my-hyprland;
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
