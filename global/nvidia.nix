{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    open = true;

    nvidiaSettings = true;
  };
}
