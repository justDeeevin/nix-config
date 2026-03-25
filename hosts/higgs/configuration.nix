{ pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia-prime.nix
  ];

  # Fix for internal speakers. See https://forums.fedoraforum.org/showthread.php?331130-Fixing-ALC298-audio-(no-sound-from-speakers)
  systemd.services.speakerVerbs =
    let
      script = pkgs.fetchurl {
        url = "https://github.com/joshuagrisham/galaxy-book2-pro-linux/raw/refs/heads/main/sound/necessary-verbs.sh";
        hash = "sha256-b4liW+sNCLtssKUgRSjUxwHbvQTnOmWDQMIJZ69EMkw=";
        executable = true;
      };
    in
    {
      wantedBy = [ "default.target" ];
      after = [ "getty.target" ];
      description = "Run internal speaker fix at startup";
      serviceConfig = {
        Type = "oneshot";
        User = "root";
        Group = "root";
        RemainAfterExit = "yes";
        ExecStart = script;
        Restart = "on-failure";
        RestartSec = "5s";
      };
      path = [ pkgs.alsa-tools ];
    };

  services.upower.enable = true;

  services.displayManager.ly.settings =
    let
      brightnessctl = lib.getExe pkgs.brightnessctl;
    in
    {
      battery_id = "BAT0";
      brightness_down_cmd = "${brightnessctl} set 5%-";
      brightness_down_key = "F2";
      brightness_up_cmd = "${brightnessctl} set +5%";
      brightness_up_key = "F3";
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
