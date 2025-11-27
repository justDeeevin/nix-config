{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  sops.secrets =
    let
      sopsFile = ./secrets.yaml;
      group = "cloudflared";
      owner = "cloudflared";
    in
    {
      tunnel_creds = { inherit owner group sopsFile; };
      tunnel_cert = { inherit owner group sopsFile; };
    };

  services.cloudflared = {
    enable = true;
    certificateFile = config.sops.secrets.tunnel_cert.path;
    tunnels.field = {
      credentialsFile = config.sops.secrets.tunnel_creds.path;
      default = "http_status:404";
      warp-routing.enabled = true;
    };
  };

  systemd.services.cloudflared-tunnel-field.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "cloudflared";
  };

  users.users.cloudflared = {
    isSystemUser = true;
    group = "cloudflared";
  };
  users.groups.cloudflared = { };

  environment.systemPackages = [ pkgs.cloudflared ];

  networking.interfaces.ens18 = {
    ipv4.addresses = [
      {
        address = "192.168.86.44";
        prefixLength = 24;
      }
    ];
    useDHCP = false;
  };
}
