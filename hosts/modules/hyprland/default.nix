{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    wofi
  ];

  programs.waybar.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
}
