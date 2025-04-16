{pkgs, ...}: {
  imports = [./modules];

  home = {
    username = "thiago";
    homeDirectory = "/home/thiago";
    stateVersion = "23.11";
    packages = with pkgs; [
      #inputs.dwl.packages.${system}.default
      #freecad-wayland
      #librecad
      jellyfin-media-player
      wlogout
      floorp
      ani-cli
      manga-cli
      libreoffice-qt6-fresh
      thunderbird
      kdePackages.dolphin
    ];
  };
}
