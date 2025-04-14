{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./neovim
    #./nvim
    ./git
    ./shell
    ./wezterm
    ./hyprland
    ./waybar
    ./stylix
  ];
}
