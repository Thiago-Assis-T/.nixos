{_, ...}: {
  services.calibre-server = {
    enable = true;
    user = "thiago";
    openFirewall = true;
    libraries = ["/home/thiago/data/books"];
  };
}
