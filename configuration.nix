# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./disko-config.nix
      ./cachix.nix
    ];

  nix = {
    # enable flakes
    settings.experimental-features = [ "nix-command" "flakes" ];
    # prune the nix store periodically to prevent using too much disk space
    optimise.automatic = true;

    # weekly garbage collection of 1 month+ old artifacts
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1M"; # month is capital m
    };
  };

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        extraEntries = ''
          menuentry "UEFI Firmware Settings" --class efi {
            fwsetup
          }
        '';
      };
    };
  };

  networking = {
    hostName = "photonix";
    networkmanager.enable = true;
    # wireless.enable = true; # enables wireless support via wpa_supplicant (instead of NetworkManager!)

    # fuck iptables all my homies hate iptables
    nftables.enable = true;

    # configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  time.timeZone = "America/New_York";

  i18n = let locale = "en_US.UTF-8"; in {
    defaultLocale = locale;
    # TODO: is this at all necessary
    extraLocaleSettings = {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = locale;
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };
  };

  hardware = {
    # enable firmware regardless of how it is licensed
    # trickles down through a few defaults to update my amd cpu's microcode
    # (see the bottom of hardware-configuration.nix)
    enableAllFirmware = true;
    # formerly opengl
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = [ pkgs.rocmPackages.clr.icd ]; # opencl
    };
    pulseaudio.enable = false; # using pipewire later
    keyboard.zsa.enable = true;
    steam-hardware.enable = true;
  };

  # support for hardcoded HIP
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip    -    -    -    -    ${pkgs.rocmPackages.clr}"
  ];

  # gdm can't detect a user whose default shell isn't in /etc/shells
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wren = {
    isNormalUser = true;
    description = "Wren";
    extraGroups = [ "networkmanager" "wheel" "wireshark" ];
  };

  # real-time scheduling priority access for pipewire
  security.rtkit.enable = true;

  # nix modules https://github.com/NixOS/nixpkgs/blob/nixos-24.11/nixos/modules/programs/
  programs = {
    firefox = import ./firefox.nix;
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gtk2;
      # TODO: how to actually use this in programs.ssh?
      enableSSHSupport = true;
    };
    ssh.startAgent = false;

    kdeconnect.enable = true;
    wireshark = {
      enable = true;
      package = pkgs.wireshark; # gui version instead of cli program tshark
    };

    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-vkcapture
        obs-backgroundremoval
        obs-source-record
        obs-source-clone
        obs-text-pthread
      ];
    };
    zsh.enable = true;
  };

  services = {
    # x11
    xserver = {
      enable = true;
      videoDrivers = ["amdgpu"];

      desktopManager.budgie.enable = true;
      displayManager.lightdm = {
        enable = true;
        background = ./assets/koi.jpg;
        greeters.slick.enable = false;
        greeters.gtk = {
          enable = true;
          theme = {
            package = (pkgs.catppuccin.gtk.override {
              flavor = "mocha";
              accents = [ "mauve" ];
            });
            name = "catppuccin-mocha-mauve-standard";
          };
          cursorTheme = {
            package = pkgs.adwaita-icon-theme;
            name = "Adwaita";
          };
          iconTheme = {
            package = (pkgs.catppuccin-papirus-folders.override {
              flavor = "mocha";
              accent = "mauve";
            });
            name = "Papirus-Dark";
          };
          extraConfig = ''
            # don't preview per-user desktop backgrounds
            user-background = false

            xft-antialias = true
            xft-dpi = 96
            xft-hintstyle = full
            xft-rgba = rgb
          '';
        };
      };

      # keymap
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;
    };
    printing.enable = true; # cups
    pcscd.enable = true; # smart card service for gpg agent
    joycond.enable = true; # nintendo controllers
    # TODO: borgmatic
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # generic command line essentials
    vim # text editor
    git
    zip unzip
    helix # the cooler text editor
    wget
    gparted
    yt-dlp # youtube downloader
    efibootmgr # boot to uefi or windows
    mission-center # task manager

    # nix stuff
    nh # nix cli helper
    home-manager # declarative config files in the home directory
    cachix # binary cache hosting
    dconf-editor

    # hell yeah programs
    libreoffice-fresh
    siril
    discord
    emote # emoji picker

    # development
    blender-hip # gpu-accelerated blender

    adwaita-icon-theme
  ];

  # TODO: proper theming
  # qt.platformTheme = "qt5ct";

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    powerline-fonts
    powerline-symbols
    twemoji-color-font # svg format
    twitter-color-emoji # cbdt (bitmap) format
    unstable.nerd-fonts.hack
    unstable.nerd-fonts.fira-code
    unstable.nerd-fonts.droid-sans-mono
    unstable.nerd-fonts.symbols-only
    vistafonts
  ];
  fonts.fontconfig = {
    defaultFonts = {
      emoji = [ "Twitter Color Emoji" ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
