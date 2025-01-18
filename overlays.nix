{ nixpkgs, nixpkgs-unstable, ... }:
let
  # overlays shared between unstable and stable nixpkgs
  shared = [
    # # fuck gnu's cgit, all my homies hate gnu's cgit
    # # download from using gitweb instead to bypass all of cgit's downtime
    # # rewritten referencing https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/gn/gnu-config/package.nix

    # # error message to potentially help lost souls dealing with the same issue:
    # # error: unable to download 'https://git.savannah.gnu.org/cgit/config.git/plain/config.guess?id=948ae97ca5703224bd3eada06b7a69f40dd15a02': HTTP error 429
    # #   >
    # #   >        response body:
    # #   >
    # #   >        <html>
    # #   >        <head><title>429 Too Many Requests</title></head>
    # #   >        <body>
    # #   >        <center><h1>429 Too Many Requests</h1></center>
    # #   >        <hr><center>nginx/1.18.0 (Trisquel GNU/Linux)</center>
    # #   >        </body>
    # #   >        </html>
    # (_final: prev: let
    #   rev = "948ae97ca5703224bd3eada06b7a69f40dd15a02";
    #   configGuess = builtins.fetchurl {
    #     name = "config.guess-${builtins.substring 0 7 rev}";
    #     url = "https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=${rev}";
    #     sha256 = "sha256-ZByuPAx0xJNU0+3gCfP+vYD+vhUBp3wdn6yNQsxFtss=";
    #   };
    #   configSub = builtins.fetchurl {
    #     name = "config.sub-${builtins.substring 0 7 rev}";
    #     url = "https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=${rev}";
    #     sha256 = "sha256-/jovMvuv9XhIcyVJ9I2YP9ZSYCTsLw9ancdcL0NZo6Y=";
    #   };
    # in {
    #   gnu-config = prev.gnu-config.overrideAttrs {
    #     unpackPhase = ''
    #       runHook preUnpack
    #       cp ${configGuess} ./config.guess
    #       cp ${configSub} ./config.sub
    #       chmod +w ./config.sub ./config.guess
    #       runHook postUnpack
    #     '';
    #   };
    # })
  ];
in [
  # allow access to unstable nixpkgs via nixpkgs.unstable
  (_final: prev: {
    unstable = import nixpkgs-unstable {
      system = prev.system;
      config.allowUnfree = prev.config.allowUnfree;
      overlays = shared;
    };
  })
] ++ shared
