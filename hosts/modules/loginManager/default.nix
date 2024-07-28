{ ... }: {
  programs.regreet = {
    enable = true;
    settings = {
      background.path = ../../../wallpapers/minimal/od_space01.png;
      gtk = {
        application_prefer_dark_theme = true;
        cursor_theme_name = "Canta-dark";
        icon_theme_name = "Canta-dark";
        theme_name = "Canta-dark";
      };
    };
  };
}
