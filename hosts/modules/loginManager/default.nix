{ inputs, ... }: {
  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = inputs.wallpaper;
        fit = "Fill";
      };
      gtk = { application_prefer_dark_theme = true; };
    };
  };
}
