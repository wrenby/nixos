{
  # text editor
  programs.helix.enable = true;
  # terminal prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
  # terminal multiplexer
  programs.zellij.enable = true;
  # better cat
  programs.bat.enable = true;
  # TODO: move zsh here
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = [ "main" "brackets" ];
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "colored-man-pages"
        # "cp"
        "dotenv"
        "extract"
        "git" "git-lfs"
        "gpg-agent"
        # "ipfs" "mosh" "ngrok"
        "per-directory-history"
        # "rsync"
        "rust"
        "starship"
        "ssh"
      ];
    };
    sessionVariables = {
      EDITOR = "vi -e";
      VISUAL = "hx";
      TERMINAL = "ghostty";
    };
    shellAliases = {
      sw = "sudo nixos-rebuild switch --flake .";
      # saving this here for if I somehow fuck up my cache settings again
      sw-fixcache = ''nixos-rebuild test --flake . --option narinfo-cache-negative-ttl 0 --option narinfo-cache-positive-ttl 0 --option substituters "https://cache.nixos.org" --option trusted-public-keys "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="'';
    };
  };
}
