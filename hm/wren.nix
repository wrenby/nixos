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
    ./terminal.nix
    catppuccin.homeManagerModules.catppuccin {
      catppuccin.enable = true;
      catppuccin.cache.enable = true;
      catppuccin.cursors.enable = false;
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
  };
  
  programs.home-manager.enable = true;
  programs.ghostty = {
    enable = true;
    package = pkgs.unstable.ghostty;
    enableZshIntegration = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
