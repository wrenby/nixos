{ config, pkgs, firefox-addons, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.wren = {
      search = {
        force = true;
        default = "DuckDuckGo";
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          }; # nixpkgs search
        }; # search engines
      };
      extensions = with firefox-addons.packages."x86_64-linux"; [
        addy_io
        bitwarden
        catppuccin-gh-file-explorer
        clearurls
        consent-o-matic
        cookie-autodelete
        temporary-containers
        ublock-origin
      ];
      bookmarks = [
        {
          name = "Toolbar Bookmarks";
          toolbar = true;
          bookmarks = [
            {
              name = "Nix";
              bookmarks = [
                {
                  name = "NixOS and Flakes Book";
                  url = "https://nixos-and-flakes.thiscute.world/";
                }
                {
                  name = "Nix Pills";
                  url = "https://nixos.org/guides/nix-pills/";
                }
                {
                  name = "Noogle";
                  url = "https://noogle.dev/";
                }
                {
                  name = "Nixpkgs";
                  url = "https://search.nixos.org/packages";
                }
                {
                  name = "Manual";
                  url = "https://nixos.org/manual/nixos/stable/";
                }
                {
                  name = "Wiki Resources";
                  url = "https://wiki.nixos.org/wiki/Resources";
                }
              ];
            }
          ];
        }
      ];
      settings = {
        "general.autoScroll" = true;
      };
      # TODO: containers
    }; # profile
  };
}
