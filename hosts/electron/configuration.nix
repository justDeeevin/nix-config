{
  imports = [ ./hardware-configuration.nix ];

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
    group = "servarr";
  };

  services.radarr = {
    enable = true;
    openFirewall = true;
    group = "servarr";
  };
}
