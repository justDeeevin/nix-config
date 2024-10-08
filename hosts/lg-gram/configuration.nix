{
  imports = [./hardware-configuration.nix ./nvidia-prime.nix];
  networking.hostName = "devin-gram"; # Define your hostname.

  services.openvpn.servers.windscribe.config = "config ${./windscribeVPN.conf}";
}
