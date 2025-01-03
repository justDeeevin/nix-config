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
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    codeshot-nvim = {
      url = "github:sergioribera/codeshot.nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sss = {
      url = "github:sergioribera/sss/sss_cli/v0.1.5";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
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

    syspower = {
      url = "github:justdeeevin/syspower-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-qtutils = {
      url = "github:hyprwm/hyprland-qtutils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nuhxboard = {
      url = "github:justdeeevin/nuhxboard";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    mkSystem = {
      hostName,
      stateVersion,
      config ? {},
      home ? {},
    }:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit stateVersion;
          inherit home;
        };
        modules = [
          inputs.home-manager.nixosModules.default
          {networking.hostName = hostName;}
          ./global
          config
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
