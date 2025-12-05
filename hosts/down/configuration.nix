{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.copyparty.nixosModules.default
  ];

  nixpkgs.overlays = [ inputs.copyparty.overlays.default ];

  users.groups.media.gid = 600;

  services.copyparty = {
    enable = true;

    group = "media";

    volumes."/" = {
      path = "/mnt/downloads";
      access = {
        r = "*";
      };
    };
  };

  services.caddy = {
    enable = true;
    virtualHosts.":80".extraConfig = "reverse_proxy :3923";
  };

  networking.firewall.allowedTCPPorts = [
    80
    3923
  ];
}
