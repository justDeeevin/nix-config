{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      mkSystem =
        {
          hostName,
          stateVersion,
          config ? { },
          home ? { },
        }:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit stateVersion;
            inherit home;
          };
          modules = [
            inputs.home-manager.nixosModules.default
            { networking.hostName = hostName; }
            ./global
            config
          ];
        };
      mkSystems =
        hosts:
        nixpkgs.lib.mapAttrs' (name: value: {
          inherit name;
          value = mkSystem (value // { hostName = name; });
        }) hosts;
    in
    {
      packages.x86_64-linux.nixvim = inputs.nixvim.legacyPackages.x86_64-linux.makeNixvimWithModule {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        module = import ./nixvim;
      };
      nixosConfigurations = mkSystems {
        devin-pc = {
          config = ./hosts/desktop/configuration.nix;
          stateVersion = "24.11";
          home = ./hosts/desktop/home.nix;
        };
        devin-gram = {
          config = ./hosts/lg-gram/configuration.nix;
          stateVersion = "24.11";
          home = ./hosts/lg-gram/home.nix;
        };
      };
    };
}
