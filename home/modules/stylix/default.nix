{ inputs, pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    image = inputs.wallpaper;
    polarity = "dark";

    iconTheme = {
      enable = true;
      package = pkgs.qogir-icon-theme;
      dark = "Qogir";

    };

    targets = {
      waybar = {

      };
    };
  };
}
