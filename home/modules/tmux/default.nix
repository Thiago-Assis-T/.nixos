{ config, lib, pkgs, ... }:
let cfg = config.programs.my-tmux;

in {
  options.programs.my-tmux = {
    enable = lib.mkEnableOption (lib.mdDoc "my-tmux");
  };
  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      newSession = true;
      terminal = "kitty";
      prefix = "C-Space";
      plugins = [{
        plugin = pkgs.tmuxPlugins.sysstat;
        extraConfig = ''
          set -g status-right "#{sysstat_cpu} | #{sysstat_mem} | #[fg=cyan]#(echo $USER)#[default]#[fg=red]@#[fg=green]#H"
        '';
      }];
      extraConfig = ''
        set-option -g escape-time 10
        set -g status-right-length 43
        bind r source-file /home/thiago/.config/tmux/tmux.conf \; display-message "Config reloaded..."
      '';
    };

  };

}
