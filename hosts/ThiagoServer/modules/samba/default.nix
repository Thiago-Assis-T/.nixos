{pkgs, ...}: {
  networking = {
    firewall.enable = true;
  };
  services = {
    # Network shares
    samba = {
      enable = true;
      openFirewall = true;
      package = pkgs.samba4Full;
      # ^^ `samba4Full` is compiled with avahi, ldap, AD etc support (compared to the default package, `samba`
      # Required for samba to register mDNS records for auto discovery
      # See https://github.com/NixOS/nixpkgs/blob/592047fc9e4f7b74a4dc85d1b9f5243dfe4899e3/pkgs/top-level/all-packages.nix#L27268
      settings.tdarr = {
        path = "/home/thiago/tdarr";
        writable = "true";
        comment = "tdarr dirs for nodes";
      };

      settings.data = {
        path = "/home/thiago/data";
        writable = "true";
        comment = "Data Library";
      };
    };
    avahi = {
      publish.enable = true;
      publish.userServices = true;
      # ^^ Needed to allow samba to automatically register mDNS records (without the need for an `extraServiceFile`
      nssmdns4 = true;
      # ^^ Not one hundred percent sure if this is needed- if it aint broke, don't fix it
      enable = true;
      openFirewall = true;
    };
    samba-wsdd = {
      # This enables autodiscovery on windows since SMB1 (and thus netbios) support was discontinued
      enable = true;
      openFirewall = true;
    };
  };
}
