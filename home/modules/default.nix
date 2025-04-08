{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./nixvim
    #./nvim
    ./git
    ./shell
    ./wezterm
    ./hyprland
    ./waybar
    ./stylix
  ];
}
