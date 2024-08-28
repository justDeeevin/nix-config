{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:justdeeevin/nvim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    drg-mod-manager = {
      url = "github:trumank/mint";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:marcecoll/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    mkSystem = {
      configPath,
      stateVersion,
      extraHome ? null,
    }:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit stateVersion;
          inherit extraHome;
        };
        modules = [
          configPath
          ./global
          inputs.home-manager.nixosModules.default
        ];
      };
  in {
    nixosConfigurations = {
      devin-pc = mkSystem {
        configPath = ./hosts/desktop/configuration.nix;
        stateVersion = "23.11";
        extraHome = ./hosts/desktop/home.nix;
      };
      devin-gram = mkSystem {
        configPath = ./hosts/lg-gram/configuration.nix;
        stateVersion = "24.05";
      };
    };
  };
}
