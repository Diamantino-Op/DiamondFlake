{ pkgs, ... }:
let
  rider = pkgs.jetbrains.rider;
in
{
  home.packages = [ rider ];

  # Ensure running on Wayland
  xdg.configFile."JetBrains/Rider${rider.version}/rider64.vmoptions".text =
    "-Dawt.toolkit.name=WLToolkit";
}