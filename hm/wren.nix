{
  inputs,
  lib,
  config,
  pkgs,
  catppuccin,
  ...
}: {
  imports = [
    ./firefox.nix
    ./git.nix
    ./dconf.nix
    catppuccin.homeManagerModules.catppuccin {
      catppuccin.enable = true;
      catppuccin.cache.enable = true;
    }
  ];

  home = {
    username = "wren";
    homeDirectory = "/home/wren";
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "24.11";
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-rime ];
    uim.toolbar = "gtk3-systray";
  };
  
  # Add stuff for your user as you see fit:
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager
  programs.home-manager.enable = true;
  programs.ghostty = {
    enable = true;
    package = pkgs.unstable.ghostty;
    enableZshIntegration = true;
  };
  programs.helix.enable = true;
  programs.starship.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
