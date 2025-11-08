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

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "lock";
        command = "hyprlock";
      }
      {
        event = "before-sleep";
        command = "loginctl lock-session";
      }
    ];
  };
}
