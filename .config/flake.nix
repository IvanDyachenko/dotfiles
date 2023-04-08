{
  description = "Ivan Dyachenko's system configurations";

  inputs = {
    # Nixpkgs unstable channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Nixpkgs stable channels.
    nixos-stable.url = "github:NixOS/nixpkgs/nixos-22.11";
    darwin-stable.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";

    # Pure Nix flake utility functions.
    # flake-utils.url = "github:numtide/flake-utils/master";

    # Nix modules for Darwin.
    darwin.url = "github:LnL7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Manage a user environment using Nix.
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs, darwin, home-manager, ... }: {
    darwinConfigurations."i110584086" = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [ ./nixpkgs/darwin-configuration.nix ];
      specialArgs = {
        inherit home-manager;
      };
    };
  };
}
