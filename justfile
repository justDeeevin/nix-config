set shell := ["nu", "-c"]

switch:
    # nh os switch .
    sudo nixos-rebuild switch --flake .

switch-bell:
    just switch | ignore; print "\a"

clean:
    # nh clean all --no-direnv
    sudo nix-collect-garbage -d
