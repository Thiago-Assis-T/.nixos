{ ... }:
{
  # Use the systemd-boot EFI boot loader.
  boot = {
    plymouth.enable = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        memtest86.enable = true;
        configurationLimit = 5;
      };
      timeout = 2;
    };
  };
}
