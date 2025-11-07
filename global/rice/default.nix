{
  imports = [
    ./hypr.nix
    ./stylix.nix
    ./shell.nix
  ];

  programs.vicinae = {
    enable = true;
    systemd.enable = true;
  };

}
