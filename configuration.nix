# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, ... }:

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

  boot.loader = {
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
      theme = pkgs.catppuccin-grub;
      splashImage = null;
    };
  };

  networking = {
    hostName = "photonix"; # Define your hostname.
    # allow KDE connect traffic
    firewall = rec {
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant (instead of NetworkManager!)

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # formerly hardware.opengl
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [ pkgs.rocmPackages.clr.icd ]; # opencl
  };
  # gtx 970 too old for nix to recommend open source drivers
  # hardware.nvidia.open = false;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = ["amdgpu"];
    # hardware.nvidia.modesetting.enable = true;

    displayManager.gdm.enable = true;
    desktopManager.budgie.enable = true;

    # keymap
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # support for hardcoded HIP 
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip    -    -    -    -    ${pkgs.rocmPackages.clr}"
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wren = {
    isNormalUser = true;
    description = "Wren";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox = {
    enable = true;
    policies = {
      # informed by https://www.stigviewer.com/stig/mozilla_firefox/
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
        DisabledCiphers = {
	  "TLS_RSA_WITH_3DES_EDE_CBC_SHA" = true;
        };
        SSLVersionMin = "tls1.2";
      };
      FirefoxHome = {
        Search = true;
        TopSites = true;
        SponsoredTopSites = false;
        Pocket = false;
        SponsoredPocket = false;
        Highlights = true;
        Snippets = false;
        Locked = true;
      };
      Preferences = let
        lock-false = { Value = false; Status = "locked"; };
        lock-true = { Value = true; Status = "locked"; };
      in {
        "browser.contentblocking.category" = { Value = "strict"; };
        "browser.search.update" = lock-false;
        "dom.disable_window_flip" = lock-true;
        "dom.disable_window_move_resize" = lock-true;
        "exensions.pocket.enabled" = lock-false;
        "privacy.trackingprotection.cryptomining.enabled" = lock-true;
      };
    };
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gtk2;
    enableSSHSupport = true;
  };
  programs.ssh.startAgent = false;
  services.pcscd.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # generic command line essentials
    vim
    helix # text editor
    wget
    gparted
    yt-dlp # youtube downloader
    borgmatic # declarative backups
    efibootmgr # boot to uefi or windows
    mission-center # task manager
    unstable.ghostty # terminal emulator 
    zsh

    # nix stuff
    nh # nix cli helper
    home-manager # declarative config files in the home directory
    cachix # binary cache hosting
    dconf-editor
    dconf2nix # convert dconf to home-manager nix code

    # hell yeah programs
    libreoffice-fresh
    siril
    discord
    obs-studio
    obs-studio-plugins.obs-vkcapture
    emote # emoji picker
    kdePackages.kdeconnect-kde

    # development
    clinfo # opencl info
    vscode-fhs # vs code with native extension support
    blender-hip # gpu-accelerated blender

    # theming
    catppuccin-gtk
    catppuccin-qt5ct
    catppuccin-kvantum
    catppuccin-plymouth
  ];
  qt.platformTheme = "qt5ct";

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
      emoji = [ "Twitter Color Emoji"];
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
