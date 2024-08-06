{ inputs, pkgs, ... }: {

  imports = [ ./modules ];

  programs.my-nvim.enable = true;
  programs.my-shell.enable = true;
  programs.my-git.enable = true;
  programs.my-swaync.enable = true;
  programs.my-kitty.enable = true;
  programs.my-nnn.enable = true;

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
      jellyfin-media-player
      floorp
      pavucontrol
      freecad
      webcord-vencord
    ];

    file = {
      "Pictures/wallpaper.png".source = "${inputs.wallpaper}";

    };
  };
}
