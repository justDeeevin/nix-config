{
  imports = [
    ./hypr.nix
    ./niri.nix
    ./stylix.nix
    ./noctalia.nix
  ];

  programs.vicinae = {
    enable = true;
    systemd.enable = true;
  };
}
