{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
  ];
  documentation = {
    enable = true;
    dev.enable = true;
    doc.enable = true;
    info.enable = true;
    man = {
      enable = true;
      generateCaches = true;
    };
  };
}
