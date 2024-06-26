{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    image = ../../../wallpapers/tokyo_rainy_road.jpg;
    cursor = {
      name = "BreezeX-RosePine-Linux";
      package = pkgs.rose-pine-cursor;
      size = 24;
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
