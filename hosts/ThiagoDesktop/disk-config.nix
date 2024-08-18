{
  disko.devices = {
    disk = {
      disk1 = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            mdadm = {
              size = "100%";
              content = {
                type = "mdraid";
                name = "raid0";
              };
            };
          };
        };
      };
      disk2 = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {
            mdadm = {
              size = "100%";
              content = {
                type = "mdraid";
                name = "raid0";
              };
            };
          };
        };
      };
    };
    mdadm = {
      raid0 = {
        type = "mdadm";
        level = 0;
        content = {
          type = "btrfs";
          extraArgs = [ "-f" ]; # Override existing partition
          # Subvolumes must set a mountpoint in order to be mounted,
          # unless their parent is mounted
          subvolumes = {
            # Subvolume name is different from mountpoint
            "/" = { mountpoint = "/"; };
            # Subvolume name is the same as the mountpoint
            "/home" = {
              mountOptions = [ "compress=zstd" ];
              mountpoint = "/home";
            };
            # Parent is not mounted so the mountpoint must be set
            "/nix" = {
              mountOptions = [ "compress=zstd" "noatime" ];
              mountpoint = "/nix";
            };
            # Subvolume for the swapfile
            "/swap" = {
              mountpoint = "/.swapvol";
              swap = { swapfile.size = "35G"; };
            };
          };
          mountpoint = "/";
        };
      };
    };
  };
}
