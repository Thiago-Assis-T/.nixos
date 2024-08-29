# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.blacklistedKernelModules = [ ];
  boot.kernelParams = [ "intal_pstate=active" ];
  boot.kernel.sysctl = {
    "kernel.sched_cfs_bandwidth_slice_us" = 3000;
    "net.ipv4.tcp_fin_timeout" = 5;
    "vm.max_map_count" = 2147483642;
  };

  services.logind.lidSwitch = "ignore";
  services.logind.lidSwitchDocked = "ignore";
  services.logind.extraConfig = "HandleLidSwitch=ignore";
  #nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  nix.settings.system-features = [
    "nixos-test"
    "benchmark"
    "big-parallel"
    "gccarch-skylake"
    "gcctune-skylake"
  ];
  nixpkgs = {
    config = { allowUnfree = true; };
    hostPlatform = {
      system = "x86_64-linux";
      config = "x86_64-unknown-linux-gnu";
      #gcc.arch = "skylake";
      #gcc.tune = "skylake";
    };
  };
  hardware = {
    enableAllFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-sdk
        intel-media-driver
        intel-vaapi-driver
        vaapiVdpau
        libvdpau-va-gl
        intel-compute-runtime
      ];
    };
    cpu.intel.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
