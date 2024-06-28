{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./nvim
    ./git
    ./shell
    ./hyprland
    ./waybar
  ];
}
