{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/x86_64-linux";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        systems.follows = "systems";
      };
    };

    nixcord = {
      url = "github:flameflag/nixcord";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
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
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        systems.follows = "systems";
      };
    };

    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    starship-jj = {
      url = "gitlab:lanastara_foss/starship-jj";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        systems.follows = "systems";
      };
    };

    crane.url = "github:ipetkov/crane";

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs/v0.0.12";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia/v4.7.7";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        noctalia-qs.follows = "noctalia-qs";
      };
    };

    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    copyparty = {
      url = "github:9001/copyparty";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    nightly-nvim = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    deadlock-webhook = {
      url = "github:justdeeevin/deadlock-webhook";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        crane.follows = "crane";
      };
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      myLib.mkEnableList =
        list:
        builtins.listToAttrs (
          builtins.map (
            x:
            if builtins.isAttrs x then
              {
                inherit (x) name;
                value = (builtins.removeAttrs x [ "name" ]) // {
                  enable = true;
                };
              }
            else
              {
                name = x;
                value.enable = true;
              }
          ) list
        );
      inherit (pkgs) lib;

      mkSystem =
        {
          hostName,
          stateVersion,
          config ? { },
          home ? { },
          graphical ? true,
        }:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              inputs
              stateVersion
              home
              graphical
              myLib
              ;
          };
          modules = [
            { networking = { inherit hostName; }; }
            ./global
            config
          ]
          ++ lib.optional graphical inputs.home-manager.nixosModules.default;
        };
      mkSystems =
        hosts:
        lib.mapAttrs' (name: value: {
          inherit name;
          value = mkSystem (value // { hostName = name; });
        }) hosts;
    in
    {
      packages.${system}.nixvim = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
        inherit pkgs;
        module = import ./nixvim;
        extraSpecialArgs = {
          inherit inputs myLib;
        };
      };
      nixosConfigurations = mkSystems {
        # Desktop
        graviton = {
          config = ./hosts/graviton/configuration.nix;
          stateVersion = "24.11";
          home = ./hosts/graviton/home.nix;
        };
        # Laptop
        higgs = {
          config = ./hosts/higgs/configuration.nix;
          stateVersion = "25.05";
          home = ./hosts/higgs/home.nix;
        };
        # Homelab VPN VM
        field = {
          config = ./hosts/field/configuration.nix;
          stateVersion = "25.05";
          graphical = false;
        };
        # Homelab qBittorrent VM
        tau = {
          config = ./hosts/tau/configuration.nix;
          stateVersion = "25.05";
          graphical = false;
        };
        # Homelab Servarr VM
        electron = {
          config = ./hosts/electron/configuration.nix;
          stateVersion = "25.05";
          graphical = false;
        };
        # Homelab Jellyfin VM
        photon = {
          config = ./hosts/photon/configuration.nix;
          stateVersion = "25.05";
          graphical = false;
        };
        # Homelab Caddy VM
        charm = {
          config = ./hosts/charm/configuration.nix;
          stateVersion = "25.05";
          graphical = false;
        };
        # Homelab Copyparty VM
        down = {
          config = ./hosts/down/configuration.nix;
          stateVersion = "25.05";
          graphical = false;
        };
      };
      devShell.${system} = pkgs.mkShell {
        packages = with pkgs; [
          just
          sops
        ];
      };
    };
}
