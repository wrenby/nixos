{ pkgs, ...}:
{
  programs = {
    # text editor
    helix.enable = true;
    # terminal prompt
    starship.enable = true;
    # terminal multiplexer
    zellij.enable = true;
    # better cat
    # temporarily disabled because of HTTP 429 responses
    # TODO: my fault somehow or not?
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
    };
    # TODO: move zsh here
    zsh = {
      enable = true;
      enableCompletion = true;
      autocd = true;
      autosuggestion.enable = true;
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
        EDITOR = "hx";
        VISUAL = "hx";
      };
      shellAliases = {
        sw = "sudo nixos-rebuild switch --flake /etc/nixos";
      };
    };
  };
}
