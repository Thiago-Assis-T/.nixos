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
        input = {
          kb_layout = "br";
          follow_mouse = 1;
          touchpad = {
            natural_scroll = true;
          };
        };
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          layout = "dwindle";
        };
        decoration = {
          rounding = 0;
          blur = {
            enabled = true;
            size = 3;

            passes = 1;
          };
          drop_shadow = true;
          shadow_offset = "0 5";
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(00000099)";
        };
        animations = {
          enabled = false;
        };

        "$mod" = "SUPER";
        bind = [
          "$mod,W,exec,floorp"
          "$mod,Q,killactive"
          "$mod,Return,exec,foot"
          "$mod,M,exit"
          "$mod,V,togglefloating"
        ];
      };
    };
  };
}
