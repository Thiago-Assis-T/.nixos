{ ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      term = "foot";
      allow-images = true;
      hide-scroll = true;
      insensitive = true;
    };
  };
}
