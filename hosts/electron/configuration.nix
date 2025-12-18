{
  imports = [ ./hardware-configuration.nix ];

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  users.groups.media.gid = 600;
  users.users.media = {
    uid = 600;
    isSystemUser = true;
    group = "media";
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
    user = "media";
  };

  services.radarr = {
    enable = true;
    openFirewall = true;
    user = "media";
  };

  services.caddy = {
    enable = true;
    virtualHosts.":80".extraConfig = ''
      handle /sonarr* {
        reverse_proxy :8989
      }
      handle /radarr* {
        reverse_proxy :7878
      }
      handle /prowlarr* {
        reverse_proxy :9696
      }
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
}
