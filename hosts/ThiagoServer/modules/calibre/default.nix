{_, ...}: {
  services.calibre-server = {
    enable = false;
    user = "thiago";
    port = 8089;
    openFirewall = true;
    libraries = ["/home/thiago/data/books"];
  };
}
