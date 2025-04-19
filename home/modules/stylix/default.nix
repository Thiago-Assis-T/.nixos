{
  inputs,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = true;
    image = inputs.wallpaper;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    polarity = "dark";

    iconTheme = {
      enable = true;
      package = pkgs.qogir-icon-theme;
      dark = "Qogir";
    };

    targets = {
      waybar = {
        enable = true;
      };
      nvf = {
        enable = true;
        transparentBackground = true;
        plugin = "mini-base16";
      };
    };
  };
}
