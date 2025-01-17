# basically this whole file only exists because I want sudo-ed terminal programs to use the catppuccin theme
{
  inputs,
  lib,
  config,
  pkgs,
  catppuccin,
  ...
}: {
  imports = [
    catppuccin.homeManagerModules.catppuccin {
      catppuccin.enable = true;
      catppuccin.cache.enable = true;
    }
  ];

  home = {
    username = "root";
    homeDirectory = "/root";
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "24.11";
  };

  # Enable home-manager
  programs.home-manager.enable = true;
  programs.helix.enable = true;
  programs.starship.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
