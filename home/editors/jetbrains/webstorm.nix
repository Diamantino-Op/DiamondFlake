{ pkgs, ... }:
let
  webstorm = pkgs.jetbrains.webstorm;
in
{
  home.packages = [ webstorm ];

  # Ensure running on Wayland
  xdg.configFile."JetBrains/WebStorm${webstorm.version}/webstorm64.vmoptions".text =
    "-Dawt.toolkit.name=WLToolkit";
}