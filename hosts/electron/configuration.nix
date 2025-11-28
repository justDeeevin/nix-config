{
  imports = [ ./hardware-configuration.nix ];

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  users.groups.media.gid = 600;

  services.sonarr = {
    enable = true;
    openFirewall = true;
    group = "media";
  };

  services.radarr = {
    enable = true;
    openFirewall = true;
    group = "media";
  };
}
