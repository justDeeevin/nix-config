{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    inputs.deadlock-webhook.nixosModules.default
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
      webhook_url = { inherit owner group sopsFile; };
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

  services.deadlock-webhook = {
    enable = true;
    webhook_url_file = config.sops.secrets.webhook_url.path;
    role_id = 1426210333630136531;
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
}
