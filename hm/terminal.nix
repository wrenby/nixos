{ pkgs, ...}:
{
  # text editor
  programs.helix.enable = true;
  # terminal prompt
  programs.starship.enable = true;
  # terminal multiplexer
  programs.zellij.enable = true;
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
  };
  # TODO: move zsh here
  programs.zsh = {
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
      sw = "sudo nixos-rebuild switch --flake .";
    };
  };
}
