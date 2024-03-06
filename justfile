base := "sudo nixos-rebuild "
flake := "--flake ."

switch:
    {{base}} switch {{flake}}

clean:
    sudo nix-collect-garbage -d
    sudo nix store optimise
    nix-collect-garbage -d
    nix store optimise
