{ ... }:

{
  programs.git = {
    enable = true;
    userEmail = "git@wren.dev";
    userName = "Wren Baxter";
    signing = {
      key = "B1661C54C1356B2F488D52DE5866DB62B2ED6EEE";
      signByDefault = true;
    };

    # better diff highlighter
    delta.enable = true;
    # support for big binary files
    lfs.enable = true;

    # global gitignore
    ignores = [
      "*~"
      "*.swp"
    ];
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };
}
