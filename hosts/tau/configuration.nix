{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  services.qbittorrent = {
    enable = true;
    profileDir = "/mnt/downloads/";
    openFirewall = true;
    group = "media";
  };

  users.groups.media.gid = 600;

  environment.systemPackages = [ (pkgs.ouch.override { enableUnfree = true; }) ];

  services.caddy = {
    enable = true;
    virtualHosts.":80".extraConfig = "reverse_proxy :8080";
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
}
