{ pkgs, ... }:
{

  imports = [ ./modules ];

  home = {
    username = "thiago";
    homeDirectory = "/home/thiago";
    stateVersion = "23.11";
    packages = with pkgs; [
      gnome-disk-utility
      kdePackages.dolphin
      floorp
      #freecad-wayland
      librecad
      thunderbird
      libreoffice-qt6-fresh
    ];

  };
}
