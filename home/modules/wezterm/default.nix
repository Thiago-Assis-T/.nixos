{ pkgs, ... }:

{
  home.packages = with pkgs; [ nerd-fonts.shure-tech-mono ];
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    extraConfig = builtins.readFile ./wezterm.lua;

  };

}
