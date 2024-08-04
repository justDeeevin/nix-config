{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:justdeeevin/nvim-config/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    drg-mod-manager = {
      url = "github:trumank/mint";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , ...
    } @ inputs: {
      nixosConfigurations = {
        devin-pc = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/desktop/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
        devin-gram = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/lg-gram/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}
