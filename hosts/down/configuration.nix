{ config, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.copyparty.nixosModules.default
    inputs.deadlock-webhook.nixosModules.default
  ];

  nixpkgs.overlays = [ inputs.copyparty.overlays.default ];

  users.groups.media.gid = 600;

  services.copyparty = {
    enable = true;

    group = "media";

    volumes."/" = {
      path = "/media";
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

  sops.secrets.webhook_url.sopsFile = ./secrets.yaml;

  services.deadlock-webhook = {
    enable = true;
    webhook_url_file = config.sops.secrets.webhook_url.path;
    role_id = 1426210333630136531;
  };
}
