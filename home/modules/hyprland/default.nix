{ config, lib, ... }:

let
  cfg = config.programs.my-hyprland;
in
{

  options.programs.my-hyprland = {
    enable = lib.mkEnableOption (lib.mdDoc "my-hyprland");
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd.enable = true;

      settings = {
        decoration = {
          shadow_offset = "0 5";
          "col.shadow" = "rgba(00000099)";
        };

        "$mod" = "SUPER";
        bind = [
          "$mod,W,exec,floorp"
          "$mod,Return,exec,wezterm"
        ];
      };
    };
  };
}
