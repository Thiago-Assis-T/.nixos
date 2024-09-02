{ config, lib, ... }:

let cfg = config.programs.my-kitty;
in {
  options.programs.my-kitty = {
    enable = lib.mkEnableOption (lib.mdDoc "my-kitty");
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableBashIntegration = true;
      extraConfig = ''
        linux_display_server wayland
        # Colors

        foreground #979eab
        background #282c34

        color0 #282c34
        color1 #e06c75
        color2 #98c379
        color3 #e5c07b
        color4 #61afef
        color5 #be5046
        color6 #56b6c2
        color7 #979eab
        color8 #393e48
        color9 #d19a66
        color10 #56b6c2
        color11 #e5c07b
        color12 #61afef
        color13 #be5046
        color14 #56b6c2
        color15 #abb2bf

        # Tab Bar

        active_tab_foreground   #282c34
        active_tab_background   #979eab
        inactive_tab_foreground #abb2bf
        inactive_tab_background #282c34
      '';
    };
  };
}
