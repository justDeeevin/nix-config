{
  imports = [
    ./hypr.nix
    ./swaylock.nix
  ];
  sops.secrets.OPENAI_API_KEY = {
    sopsFile = ./secrets.yaml;
  };
}
