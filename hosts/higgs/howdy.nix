{ lib, ... }:
{
  services.howdy = {
    enable = true;
    control = "sufficient";
  };

  services.linux-enable-ir-emitter.enable = true;

  security.pam.services.ly.howdy.enable = false;

  systemd.services."polkit-agent-helper@".serviceConfig = {
    DeviceAllow = "char-video4linux rw";
    PrivateDevices = "no";
  };
}
