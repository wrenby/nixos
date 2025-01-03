{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/disk/by-id/ata-ST1000DM003-1ER162_Z4Y3T9X8";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "550M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" "dmask=0077" ];
              };
            };
            swap = {
              size = "40G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                subvolumes = {
                  # system subvolume is anything that can be restored with a nix rebuild
                  "system" = {};
                  "system/rootfs" = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd" ];
                  };
                  "system/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };

                  # data subvolume is stuff that is likely to require full backups
                  "data" = {};
                  "data/home" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home";
                  };
                }; # subvolumes
              }; # content
            }; # root
          }; # partitions
        }; # content
      }; # main
    }; # disk
  }; # devices
}

