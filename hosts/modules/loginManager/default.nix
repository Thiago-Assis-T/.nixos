{ pkgs, ... }: {
  programs.regreet = {
    enable = true;
    settings = {
      background.path = ../../../wallpapers/minimal/od_space01.png;
      gtk = { application_prefer_dark_theme = true; };
    };
  };
}
