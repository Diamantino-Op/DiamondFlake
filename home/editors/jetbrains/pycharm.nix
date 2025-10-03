{ pkgs, ... }:
let
  pycharm = pkgs.jetbrains.pycharm-professional;
in
{
  home.packages = [ pycharm ];

  # Ensure running on Wayland
  xdg.configFile."JetBrains/PyCharm${pycharm.version}/pycharm64.vmoptions".text =
    "-Dawt.toolkit.name=WLToolkit";
}