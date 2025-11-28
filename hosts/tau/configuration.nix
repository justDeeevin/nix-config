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
}
