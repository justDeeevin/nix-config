switch:
    nh os switch .

clean:
    nh clean all

darwin:
    sudo darwin-rebuild switch --flake .
