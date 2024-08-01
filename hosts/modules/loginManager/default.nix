{ inputs, ... }: {
  programs.regreet = {
    enable = true;
    settings = {
      background.path = inputs.wallpaper;
      gtk = { application_prefer_dark_theme = true; };
    };
  };
}
