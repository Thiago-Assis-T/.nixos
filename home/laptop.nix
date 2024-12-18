{ inputs, pkgs, ... }:
{

  imports = [ ./modules ];

  programs.my-nvim.enable = true;
  programs.my-shell.enable = true;
  programs.my-git.enable = true;
  programs.my-swaync.enable = true;
  programs.my-kitty.enable = true;
  programs.my-tmux.enable = true;

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf.desktop" ];
        "text/plain" = [ "neovim.desktop" ];
      };
    };
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
      libreoffice-qt6-fresh
      webcord
      youtube-music
      jellyfin-media-player
      floorp
      pavucontrol
      popsicle
    ];

    file = {
      "Pictures/wallpaper".source = "${inputs.wallpaper}";

    };
  };
}
