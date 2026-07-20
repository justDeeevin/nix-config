set shell := ["nu", "-c"]

switch:
    nh os switch .

switch-bell:
    just switch | ignore; print "\a"

clean:
    nh clean all --no-direnv
