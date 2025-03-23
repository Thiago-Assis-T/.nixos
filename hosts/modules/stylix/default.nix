{ inputs, pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    image = inputs.wallpaper;
    polarity = "dark";
    cursor = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir Cursors";
      size = 24;

    };
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.shure-tech-mono;
        name = "ShureTechMono Nerd Font Propo";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
    opacity = {
      desktop = 0.0;
      terminal = 0.9;
    };

  };
}
