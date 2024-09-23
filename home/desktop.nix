{ inputs, pkgs, ... }: {

  imports = [ ./modules ];

  programs.my-nvim.enable = true;
  programs.my-shell.enable = true;
  programs.my-git.enable = true;
  programs.my-swaync.enable = true;
  programs.my-kitty.enable = true;
  programs.my-tmux.enable = true;

  programs.nnn = { enable = true; };

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
      zathura
      pistol
      floorp
      pavucontrol
      freecad-wayland
      webcord-vencord
      youtube-music
      cpu-x
    ];

    file = {
      "Pictures/wallpaper".source = "${inputs.wallpaper}";

    };
  };
}
