{ ... }: {
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };
  ##hardware.printers = {
  #  ensurePrinters = [{
  #    name = "Epson_L3150";
  #    location = "Home";
  #    #deviceUri = "http://192.168.178.2:631/printers/Dell_1250c";
  #    #model = "drv:///sample.drv/generic.ppd";
  #    ppdOptions = { PageSize = "A4"; };
  #  }];
  #  ensureDefaultPrinter = "Epson_L3150";
  #};
}
