{ pkgs, ... }:
{
  imports = [
    ./anyrun
    ./browsers/zen.nix
    ./media
    ./gtk.nix
    ./office
    ./qt.nix
  ];

  home.packages = with pkgs; [
    halloy
    tdesktop

    gnome-calculator
    gnome-control-center

    overskride
    resources
    wineWowPackages.wayland
  ];
}