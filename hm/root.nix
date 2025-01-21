# basically this whole file only exists because I want sudo-ed terminal programs to use the catppuccin theme
inputs @ {
  ...
}: {
  imports = [
    ./terminal.nix
    inputs.catppuccin.homeManagerModules.catppuccin {
      catppuccin.enable = true;
    }
  ];

  home = {
    username = "root";
    homeDirectory = "/root";
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
