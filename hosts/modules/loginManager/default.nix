{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ canta-theme ];
  programs.regreet = {
    enable = true;
    settings = {
      background.path = ../../../wallpapers/minimal/od_space01.png;
      gtk = {
        application_prefer_dark_theme = true;
        cursor_theme_name = "canta-dark";
        icon_theme_name = "canta-dark";
        theme_name = "canta-dark";
      };
    };
  };
}
