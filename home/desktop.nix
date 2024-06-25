{ pkgs, ... }:
{

  imports = [ ./modules ];

  programs.my-nvim.enable = true;
  programs.my-shell.enable = true;
  programs.my-git.enable = true;
  programs.my-hyprland.enable = true;
  programs.my-style.enable = true;

  xdg = {
    enable = true;
    mime.enable = true;
    portal = {
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
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
      foot
    ];
  };
}
