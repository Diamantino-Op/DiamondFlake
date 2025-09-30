{ inputs, pkgs, ... }: let
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};

in {
  programs.uwsm.enable = true;

  programs.hyprland = {
    enable = true;

    systemd.setPath.enable = true;
    withUWSM = true;
    xwayland.enable = true;

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  programs.hyprlock = {
    enable = true;

    package = inputs.hyprlock.packages.${pkgs.stdenv.hostPlatform.system}.hyprlock;
  };

  programs.hypridle = {
    enable = true;

    package = inputs.hypridle.packages.${pkgs.stdenv.hostPlatform.system}.hypridle;
  };

  programs.hyprpaper = {
    enable = true;

    package = inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.hyprpaper;
  };

  programs.hyprpolkitagent = {
    enable = true;

    package = inputs.hyprpolkitagent.packages.${pkgs.stdenv.hostPlatform.system}.hyprpolkitagent;
  };

  inputs.hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.hyprcursor;

  hardware.graphics = {
    package = pkgs-unstable.mesa;

    enable32Bit = true;
    package32 = pkgs-unstable.pkgsi686Linux.mesa;
  };

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
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
}