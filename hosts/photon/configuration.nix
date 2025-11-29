{
  imports = [ ./hardware-configuration.nix ];

  users.groups.media.gid = 600;

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    group = "media";
  };

  services.caddy = {
    enable = true;
    virtualHosts."photon.lan".extraConfig = "reverse_proxy :8096";
  };
}
