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
  imports = [ ../wofi ];
  options.programs.my-hyprland = {
    enable = lib.mkEnableOption (lib.mdDoc "my-hyprland");
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd.enable = true;
      settings = {
        exec-once = [ "${pkgs.foot}/bin/foot --server" ];
        monitor = ",preferred,auto,1";
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
        };
        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        "$mod" = "SUPER";
        bind = [
          "$mod,W,exec,${pkgs.floorp}/bin/floorp"
          "$mod,Q,killactive"
          "$mod,Return,exec,${pkgs.foot}/bin/footclient"
          "$mod, R, exec, ${pkgs.wofi}/bin/wofi -I -m -b -a --show drun"
          "$mod SHIFT, N, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw"
          "$mod,M,exit"
          "$mod,V,togglefloating"
          # Move focus with mod + arrow keys
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"
          # Switch workspaces mod + number
          "$mod,1,workspace,1"
          "$mod,2,workspace,2"
          "$mod,3,workspace,3"
          "$mod,4,workspace,4"
          "$mod,5,workspace,5"
          "$mod,6,workspace,6"
          "$mod,7,workspace,7"
          "$mod,8,workspace,8"
          "$mod,9,workspace,9"
          "$mod,0,workspace,10"
          # Move active window to workspace with mod + shift + number
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"

          # Scroll through existing workspaces with mainMod + scroll
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
        ];
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
