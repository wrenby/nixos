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
            definedAliases = [ "@np" ];
          };
          "NixOS Options" = {
            urls = [{
              template = "https://search.nixos.org/options";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            definedAliases = [ "@opt" ];
          };
          "Nix Code on GitHub" = {
            urls = [{
              template = "https://github.com/search";
              params = [
                { name = "type"; value = "code"; }
                { name = "q"; value = "lang%3Anix+{searchTerms}"; }
              ];
            }];
            definedAliases = [ "@nixgh" ];
          };
        }; # search engines
      }; # search
      extensions = with firefox-addons.packages."x86_64-linux"; [
        addy_io
        bitwarden
        catppuccin-gh-file-explorer
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
                  name = "Zero to Nix";
                  url = "https://zero-to-nix.com/";
                }
                {
                  name = "nix.dev";
                  url = "https://nix.dev/";
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
                  name = "NixOS Manual";
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
