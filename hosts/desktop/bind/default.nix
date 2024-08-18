{
  services.bind = {
    enable = true;
    listenOnIpv6 = [ "0:0:0:0:0:0:0:1" ];
    listenOn = [ "127.0.0.1" ];
    forwarders = [ "9.9.9.9" "149.122.122.122" ];
    extraOptions = ''
      recursion yes;
    '';
    # allow-query-cache { none; };

    zones."modrinth.gg" = {
      master = true;
      file = "/srv/bind/modrinth.gg.zone";
      extraConfig = "notify yes;";
    };
  };
}
