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
    virtualHosts.":80".extraConfig = "reverse_proxy :8096";
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
}
