{ inputs, pkgs, ... }:
{

  imports = [ ./modules ];

  programs = {
    my-nvim.enable = true;
    my-shell.enable = true;
    my-git.enable = true;
    my-swaync.enable = true;
    my-kitty.enable = true;
    my-tmux.enable = true;
  };

  programs.nnn = {
    enable = true;
  };

  programs.mangohud = {
    enable = true;
    enableSessionWide = false;
    #settings = { full = true; };
  };
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  xdg = {
    enable = true;
    mime.enable = true;
    portal = {
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
    };
  };
  fonts.fontconfig.enable = true;
  home = {
    username = "thiago";
    homeDirectory = "/home/thiago";
    stateVersion = "23.11";
    packages = with pkgs; [
      pistol
      floorp
      pavucontrol
      freecad-wayland
      webcord-vencord
      #discord-canary
      youtube-music
      cpu-x
      libreoffice-qt6-fresh
    ];

    file = {
      "Pictures/wallpaper".source = "${inputs.wallpaper}";

    };
  };
}
