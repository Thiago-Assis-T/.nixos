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
        # vim-like pane resizing  
        bind -r C-k resize-pane -U
        bind -r C-j resize-pane -D
        bind -r C-h resize-pane -L
        bind -r C-l resize-pane -R

        # vim-like pane switching
        bind -r k select-pane -U 
        bind -r j select-pane -D 
        bind -r h select-pane -L 
        bind -r l select-pane -R 

        # and now unbind keys
        unbind Up     
        unbind Down   
        unbind Left   
        unbind Right  

        unbind C-Up   
        unbind C-Down 
        unbind C-Left 
        unbind C-Right
        set-option -g default-terminal "screen-256color"
        set -gq allow-passthrough on
        set-option -g escape-time 10
        set -g status-right-length 43
        bind r source-file /home/thiago/.config/tmux/tmux.conf \; display-message "Config reloaded..."
      '';
    };

  };

}
