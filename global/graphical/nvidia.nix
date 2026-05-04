{
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    powerManagement.enable = true;
    open = true;
  };
}
