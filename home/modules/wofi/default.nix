{ ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      term = "kitty";
      allow-images = true;
      hide-scroll = true;
      insensitive = true;
    };
  };
}
