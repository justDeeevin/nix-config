{
  imports = [
    ./hypr.nix
  ];
  sops.secrets.OPENAI_API_KEY.sopsFile = ./secrets.yaml;
  programs.ashell.settings.settings.lock_cmd = "hyprlock &";
}
