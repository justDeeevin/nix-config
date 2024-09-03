{
  imports = [./bind.nix ./hardware-configuration.nix];

  networking.hostName = "devin-pc"; # Define your hostname. networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  programs.adb.enable = true;

  programs.alvr.enable = true;
  programs.alvr.openFirewall = true;

  virtualisation.docker.enable = true;

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
}
