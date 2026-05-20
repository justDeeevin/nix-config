{ pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia-prime.nix
    ./howdy.nix
  ];

  services.upower.enable = true;

  services.displayManager.ly.settings =
    let
      brightnessctl = lib.getExe pkgs.brightnessctl;
    in
    {
      battery_id = "BAT0";
      brightness_down_cmd = "${brightnessctl} set 5%-";
      brightness_down_key = lib.mkForce "F2";
      brightness_up_cmd = "${brightnessctl} set +5%";
      brightness_up_key = lib.mkForce "F3";
      shutdown_key = "F4";
      restart_key = "F5";
    };

  boot.loader.limine = {
    secureBoot.enable = true;
    extraEntries = ''
      /Windows
        protocol: efi
        path: uuid(0572654a-1ae9-44b8-9759-6244a2d84931):/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };
}
