# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usb_storage"
    "sd_mod"
    "rtsx_usb_sdmmc"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nix.settings.system-features = [
    "nixos-test"
    "benchmark"
    "big-parallel"
    "gccarch-skylake"
    "gcctune-skylake"
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      localSystem = {
        system = "x86_64-linux";
        gcc.arch = "skylake";
        gcc.tune = "skylake";
      };
    };
    hostPlatform = {
      system = "x86_64-linux";
      config = "x86_64-unknown-linux-gnu";
      gcc.arch = "skylake";
      gcc.tune = "skylake";
    };
  };
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
