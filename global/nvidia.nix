{ pkgs, config, ... }:
{
  hardware.graphics = {
    enable = true;
    extraPackages = [ pkgs.nvidia-vaapi-driver ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    powerManagement.enable = true;

    open = true;

    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
}
