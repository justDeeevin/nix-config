{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./stylix.nix
  ];

  programs.tofi = {
    enable = true;
    settings = {
      width = "50%";
      height = "50%";
    };
  };
}
