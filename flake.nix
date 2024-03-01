{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs =
    { self
    , nixpkgs
    , rust-overlay
    , nixpkgs-stable
    , ...
    } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = system; config.allowUnfree = true; };
      pkgs-stable = import nixpkgs-stable { inherit system; config.allowUnfree = true; };
    in
    {
      nixosConfigurations = {
        devin-pc = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; inherit pkgs; inherit pkgs-stable; };
          modules = [
            ./hosts/desktop/configuration.nix
            inputs.home-manager.nixosModules.default
            ({ pkgs, ... }: {
              nixpkgs.overlays = [ rust-overlay.overlays.default ];
              environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
            })
          ];
        };
      };
    };
}
