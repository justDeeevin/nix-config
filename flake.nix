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

  outputs =
    { self
    , nixpkgs
    , ...
    } @ inputs:
    let
      mkSystem = configPath: stateVersion: nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; inherit stateVersion; };
        modules = [
          configPath
          ./global
          inputs.home-manager.nixosModules.default
        ];
      };
    in
    {
      nixosConfigurations = {
        devin-pc = mkSystem ./hosts/desktop/configuration.nix "23.11";
        devin-gram = mkSystem ./hosts/lg-gram/configuration.nix "24.05";
      };
    };
}
