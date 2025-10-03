{
  self,
  inputs,
  ...
}:
{
  imports = [
    ./specialisations.nix
    ./terminal
    inputs.nix-index-db.homeModules.nix-index
    self.nixosModules.theme
  ];

  home = {
    username = "diamantino";
    homeDirectory = "/home/diamantino";
    stateVersion = "25.05";
    extraOutputsToInstall = [
      "doc"
      "devdoc"
    ];
  };

  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  # let HM manage itself when in standalone mode
  programs.home-manager.enable = true;
}