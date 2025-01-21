#!/bin/sh
sudo nix --extra-experimental-features "nix-command flakes" build .#nixosConfigurations.photonix.config.system.build.toplevel --dry-run