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
      '';
    };
  };
}
