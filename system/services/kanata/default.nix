{
  # keyboard remapping
  # services.kanata = {
  #    enable = true;

  #    keyboards.default.config = builtins.readFile (./. + "/main.kbd");
  # };

  services.xserver = {
    xkb.layout = "it";
    xkb.options = "eurosign:e,caps:escape";
  };

  console = {
    useXkbConfig = true;
  };
}