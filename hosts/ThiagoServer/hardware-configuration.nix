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
    "vm.dirty_background_ratio" = 5;
    #"vm.overcommit_memory" = lib.mkForce 2;
    "fs.file-max" = 2097152;
    "net.ipv4.ip_local_port_range" = "1024 65535";
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_keepalive_time" = 600;
    "net.ipv4.tcp_keepalive_probes" = 5;
    "net.ipv4.tcp_keepalive_intvl" = 15;
    "net.ipv4.ip_forward" = 0;
    "net.ipv4.tcp_syncookies" = 1;
    "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
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

  #services.xserver.videoDrivers = [ "nvidia" ];
  #environment.noXlibs = true;
  #hardware.nvidia = {
  #  modesetting.enable = true;
  #  powerManagement.enable = true;
  #  open = false;
  #  package = config.boot.kernelPackages.nvidiaPackages.beta;
  #  prime = {
  #    sync.enable = true;
  #    intelBusId = "PCI:0:2:0";
  #    nvidiaBusId = "PCI:01:0:0";
  #  };
  #};
  hardware = {
    enableAllFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
        intel-media-sdk # QSV up to 11th gen

      ];
    };
    cpu.intel.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
