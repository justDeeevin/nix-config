{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    user = "media";
  };

  users.groups.media.gid = 600;
  users.users.media = {
    uid = 600;
    isSystemUser = true;
    group = "media";
  };

  environment.systemPackages = [ pkgs.unrar ];

  services.caddy = {
    enable = true;
    virtualHosts.":80".extraConfig = "reverse_proxy :8080";
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
}
