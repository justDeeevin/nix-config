{
  imports = [ ./hardware-configuration.nix ];

  services.qbittorrent = {
    enable = true;
    profileDir = "/mnt/downloads/";
    openFirewall = true;
  };

  users.groups.media.gid = 600;
}
