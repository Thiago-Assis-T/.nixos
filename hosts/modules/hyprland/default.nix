{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wofi
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
}
