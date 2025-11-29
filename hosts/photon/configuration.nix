{
  imports = [ ./hardware-configuration.nix ];

  users.groups.media.gid = 600;

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    group = "media";
  };

  nixpkgs.config.cudaSupport = true;

  services.caddy = {
    enable = true;
    virtualHosts.":80".extraConfig = ''
      reverse_proxy :8096 {
        flush_interval -1
      }
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia.open = false;
}
