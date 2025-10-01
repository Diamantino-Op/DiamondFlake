{ inputs, pkgs, ... }: let
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};

in {
  environment.systemPackages = with pkgs; [
    kitty
    btop
    inputs.hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.hyprcursor
    inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.hyprpaper
  ];

  environment.variables.KITTY_ENABLE_WAYLAND = "1";

  programs.fish.enable = true;

  programs.starship.enable = true;

  programs.uwsm.enable = true;

  programs.hyprland = {
    enable = true;

    systemd.setPath.enable = true;
    withUWSM = true;
    xwayland.enable = true;

    # nvidiaPatches = true;

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  programs.hyprlock = {
    enable = true;

    package = inputs.hyprlock.packages.${pkgs.stdenv.hostPlatform.system}.hyprlock;
  };

  services.hypridle = {
    enable = true;

    package = inputs.hypridle.packages.${pkgs.stdenv.hostPlatform.system}.hypridle;
  };

  hardware.graphics = {
    package = pkgs.mesa;

    enable32Bit = true;
    package32 = pkgs.pkgsi686Linux.mesa;
  };

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  services.displayManager.sddm.enable = true;
  services.xserver = {
    enable = true;

    xkb.layout = "it";
    xkb.options = "eurosign:e,caps:escape";
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.pipewire = {
    enable = true;

    audio.enable = true;

    pulse.enable = true;

    alsa = {
      enable = true;
        
      support32Bit = true;
    };

    jack.enable = true;
  };

  # programs.dconf.profiles.user.databases = [
  #   {
  #     settings."org/gnome/desktop/interface" = {
  #       gtk-theme = "Adwaita";
  #       icon-theme = "Flat-Remix-Red-Dark";
  #       font-name = "Noto Sans Medium 11";
  #       document-font-name = "Noto Sans Medium 11";
  #       monospace-font-name = "Noto Sans Mono Medium 11";
  #     };
  #   }
  # ];

  # NVIDIA drivers.  

  # services.xserver.videoDrivers = [ "nvidia" ]; # If you are using a hybrid laptop add its iGPU manufacturer
  # hardware.opengl = {  
    # enable = true;  
    # driSupport = true;  
    # driSupport32Bit = true;  
  # };

  # hardware.nvidia = {
    # Enable modesetting for Wayland compositors (hyprland)
    # modesetting.enable = true;
    # Use the open source version of the kernel module (for driver 515.43.04+)
    # open = true;
    # Enable the Nvidia settings menu
    # nvidiaSettings = true;
    # Select the appropriate driver version for your specific GPU
    # package = config.boot.kernelPackages.nvidiaPackages.stable;
  # };
}