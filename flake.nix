{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    catppuccin,
    disko,
    firefox-addons,
    ...
  } @ inputs:
  let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      photonix = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs outputs;

          pkgs = import nixpkgs {
            # allow access to nixpkgs-unstable via pkgs.unstable
            inherit system;
            config.allowUnfree = true;
            overlays = (import ./overlays.nix { inherit nixpkgs nixpkgs-unstable; });
          };
        };

        modules = [
          ./configuration.nix
          disko.nixosModules.disko
          catppuccin.nixosModules.catppuccin {
            catppuccin.tty.enable = true;
            catppuccin.grub.enable = true;
            catppuccin.sddm.enable = true;
          }
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wren = import ./hm/wren.nix;
            home-manager.users.root = import ./hm/root.nix;
            home-manager.backupFileExtension = "bak";

            home-manager.extraSpecialArgs = { inherit inputs outputs firefox-addons catppuccin; };
          }
        ];
      };
    };
  };
}
