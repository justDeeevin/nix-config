{
  imports = [ ./hardware-configuration.nix ];

  services.caddy = {
    enable = true;
    virtualHosts.":80".extraConfig = ''
      reverse_proxy 192.168.86.2:8006

      handle /qbittorrent* {
        reverse_proxy 192.168.86.41:8080
      }

      handle /jellyfin* {
        reverse_proxy 192.168.86.34:8096 {
          flush_interval -1
        }
      }

      handle /sonarr* {
        reverse_proxy 192.168.86.48:8989
      }
      handle /radarr* {
        reverse_proxy 192.168.86.48:7878
      }
      handle /prowlarr* {
        reverse_proxy 192.168.86.48:9696
      }
    '';
  };
}
