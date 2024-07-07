{ pkgs, ... }:
let
  inputImage = ../../../wallpapers/tokyo_rainy_road.jpg;
  brightness = "-20";
  contrast = "0";
  fillColor = "black";
in
{
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    image = pkgs.runCommand "dimmed-background.png" { } ''
      ${pkgs.imagemagick}/bin/convert "${inputImage}" -brightness-contrast ${brightness},${contrast} -fill ${fillColor} $out
    '';
    targets = {
      nixvim = {
        transparent_bg = {
          main = true;
          sign_column = true;
        };
      };
    };
    cursor = {
      name = "BreezeX-RosePine-Linux";
      package = pkgs.rose-pine-cursor;
      size = 24;
    };
    opacity = {
      terminal = 0.8;
    };
    fonts = {
      sizes = {
        terminal = 10;
      };
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.nerdfonts.override { fonts = [ "Overpass" ]; };
        name = "Overpass Nerd Font";
      };
      serif = {
        package = pkgs.nerdfonts.override { fonts = [ "Tinos" ]; };
        name = "Tinos Nerd Font";
      };
    };
  };
}
