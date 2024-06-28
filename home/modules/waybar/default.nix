{ config, lib, ... }:

let
  cfg = config.programs.my-hyprland;
in
{
  options.programs.my-waybar = {
    enable = lib.mkEnableOption (lib.mdDoc "my-waybar");
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
        target = "hyprland-session.target";
      };
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          output = [
            "eDP-1"
            "HDMI-A-1"
          ];
          modules-left = [
            "hyprland/workspaces"
            "hyprland/mode"
            "wlr/taskbar"
          ];
          modules-center = [ "hyprland/window" ];
          modules-right = [
            "mpd"
            "temperature"
          ];
        };
      };
    };
  };
}
