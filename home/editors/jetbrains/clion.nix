{ pkgs, ... }:
let
  clion = pkgs.jetbrains.clion;
in
{
  home.packages = [ clion ];

  # Ensure running on Wayland
  xdg.configFile."JetBrains/CLion${clion.version}/clion64.vmoptions".text =
    "-Dawt.toolkit.name=WLToolkit";
}