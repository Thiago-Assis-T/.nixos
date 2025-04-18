{_, ...}: {
  services.readarr = {
    enable = true;
    openFirewall = true;
    user = "thiago";
  };
}
