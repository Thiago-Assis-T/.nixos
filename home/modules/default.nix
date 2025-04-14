{ inputs, ... }:
{
  imports = [
    #inputs.nvf.homeManagerModules.default
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
