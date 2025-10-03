{
  pkgs,
  self,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./hyprland.nix
    ./powersave.nix
  ];

  boot = {
    kernelModules = [ "i2c-dev" ];
    kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
    kernelParams = [ ];
  };

  # nh default flake
  environment.variables.NH_FLAKE = "/home/diamantino/DiamondFlake";

  hardware = {
    # xpadneo.enable = true;
    sensor.iio.enable = true;
  };

  networking.hostName = "diamondpcport";

  security.tpm2.enable = true;

  services = {
    # for SSD/NVME
    fstrim.enable = true;

    howdy = {
      enable = true;
      package = inputs.nixpkgs-howdy.legacyPackages.${pkgs.system}.howdy;
      settings = {
        core = {
          no_confirmation = true;
          abort_if_ssh = true;
        };
        video.dark_threshold = 90;
      };
    };
  };
}