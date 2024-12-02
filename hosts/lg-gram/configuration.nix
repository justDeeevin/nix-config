{pkgs, ...}: {
  imports = [./hardware-configuration.nix ./nvidia-prime.nix];
  networking.hostName = "devin-gram"; # Define your hostname.

  # Fix for internal speakers. See https://forums.fedoraforum.org/showthread.php?331130-Fixing-ALC298-audio-(no-sound-from-speakers)
  systemd.services.speakerVerbs = let
    script = pkgs.fetchurl {
      url = "https://github.com/joshuagrisham/galaxy-book2-pro-linux/raw/refs/heads/main/sound/necessary-verbs.sh";
      hash = "sha256-b4liW+sNCLtssKUgRSjUxwHbvQTnOmWDQMIJZ69EMkw=";
      executable = true;
    };
  in {
    wantedBy = ["default.target"];
    after = ["getty.target"];
    description = "Run internal speaker fix at startup";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      Group = "root";
      RemainAfterExit = "yes";
      ExecStart = "${script}";
    };
    path = [pkgs.alsa-tools];
  };

  services.desktopManager.plasma6.enable = true;
}
