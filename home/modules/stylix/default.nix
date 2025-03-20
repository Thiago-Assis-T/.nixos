{ inputs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    image = inputs.wallpaper;
    polarity = "dark";
    targets = {
      waybar = {

      };
    };
  };
}
