inputs @ {
  pkgs,
  ...
}: {
  imports = [
    ./firefox.nix
    ./git.nix
    ./dconf.nix
    ./terminal.nix
    inputs.catppuccin.homeManagerModules.catppuccin {
      catppuccin.enable = true;
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
    uim.toolbar = "gtk3-systray";
  };

  programs.home-manager.enable = true;
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium; # TODO: investigate vscodium-fhs
    extensions = with pkgs.vscode-extensions; [
      # general purpose
      aaron-bond.better-comments # coloration/formatting tweaks to make some comments stand out based on their prefix, e.g. TODO
      streetsidesoftware.code-spell-checker # spellcheck
      editorconfig.editorconfig # support for editorconfig, a tool to enforce consistent code formatting
      eamodio.gitlens # enhanced git functionality
      codezombiech.gitignore # add default gitignore files for a given developer environment
      ibm.output-colorizer # best-effort log file syntax highligting
      vscode-icons-team.vscode-icons # better icons
      # TODO: ssh remote
      # TODO: licenser
      # TODO: lorem ipsum
      # ms-vscode-remote.remote-ssh
      # ms-vscode-remote.remote-ssh-edit

      # support for [ ][x] checkboxes, :emojis:, [^1] footnotes, mermaid diagrams, and yaml front matter rendering in makdown previews
      bierner.github-markdown-preview

      # c/c++
      ms-vscode.cpptools-extension-pack # c/c++ intellisense, debugging, and cmake support
      ms-vscode.makefile-tools # code completion and debugge support for makefiles
      vadimcn.vscode-lldb # debugging via lldb
      # TODO: ninja

      # graphics
      # TODO: glsl lint
      # TODO: shader languages support
      # TODO: wgsl analyzer

      # nix
      jnoortheen.nix-ide # nix lsp and syntax highlighting
      arrterian.nix-env-selector #

      # rust
      fill-labs.dependi # dependency managment, primarily for rust/cargo
      tamasfe.even-better-toml # toml support
      rust-lang.rust-analyzer # rust lsp and syntax highlighting
      # TODO: search crates.io

      # webdev
      naumovs.color-highlight # highlight web colors (e.g. #FF00FF) with their corresponding colors
      ecmel.vscode-html-css # html and css support
      redhat.vscode-xml # xml support

      # one-offs
      golang.go # go language support
      # TODO: hugo
      ziglang.vscode-zig # zig language support

      # themes
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
    ];
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
