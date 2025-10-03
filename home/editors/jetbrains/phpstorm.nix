{ pkgs, ... }:
let
  phpstorm = pkgs.jetbrains.phpstorm;
in
{
  home.packages = [ phpstorm ];

  # Ensure running on Wayland
  xdg.configFile."JetBrains/PhpStorm${phpstorm.version}/phpstorm64.vmoptions".text =
    "-Dawt.toolkit.name=WLToolkit";
}