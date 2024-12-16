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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    posting = {
      url = "github:justdeeevin/posting-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    plasma-manager = {
      url = "github:HeitorAugustoLN/plasma-manager/";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    wezterm = {
      url = "github:wez/wezterm/main?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    syspower = {
      url = "github:justdeeevin/syspower-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    mkSystem = {
      config ? {},
      stateVersion,
      home ? {},
      hostName,
    }:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit stateVersion;
          inherit home;
        };
        modules = [
          {
            networking.hostName = hostName;
          }
          config
          ./global
          inputs.home-manager.nixosModules.default
        ];
      };
    mkSystems = hosts:
      nixpkgs.lib.mapAttrs' (name: value: {
        inherit name;
        value = mkSystem (value // {hostName = name;});
      })
      hosts;
  in {
    nixosConfigurations = mkSystems {
      devin-pc = {
        config = ./hosts/desktop/configuration.nix;
        stateVersion = "23.11";
        home = ./hosts/desktop/home.nix;
      };
      devin-gram = {
        config = ./hosts/lg-gram/configuration.nix;
        stateVersion = "24.05";
        home = ./hosts/lg-gram/home.nix;
      };
    };
  };
}
