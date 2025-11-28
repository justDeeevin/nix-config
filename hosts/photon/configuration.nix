{
  imports = [ ./hardware-configuration.nix ];

  users.groups.media.gid = 600;

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    group = "media";
  };
}
