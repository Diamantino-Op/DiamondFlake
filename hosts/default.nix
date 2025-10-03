{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations =
    let
      # shorten paths
      inherit (inputs.nixpkgs.lib) nixosSystem;

      howdy = inputs.nixpkgs-howdy;

      homeImports = import "${self}/home/profiles";

      mod = "${self}/system";
      # get the basic config to build on top of
      inherit (import mod) laptop;
      inherit (import mod) desktop;

      # get these into the module system
      specialArgs = { inherit inputs self; };
    in
    {
      diamondpc = nixosSystem {
        inherit specialArgs;
        modules = desktop ++ [
          ./diamondpc
          "${mod}/core/users.nix"
          "${mod}/core/lanzaboote.nix"

          "${mod}/programs/gamemode.nix"
          "${mod}/programs/hyprland"
          "${mod}/programs/games.nix"
          "${mod}/programs/zsh.nix"
          "${mod}/programs/home-manager.nix"

          "${mod}/network/syncthing.nix"

          "${mod}/services/kanata"
          "${mod}/services/gnome-services.nix"
          "${mod}/services/location.nix"

          "${mod}/nix"
          {
            home-manager = {
              users.diamantino.imports = homeImports."diamantino@diamondpc";
              extraSpecialArgs = specialArgs;
              backupFileExtension = ".hm-backup";
            };
          }

          # enable unmerged Howdy
          { 
            disabledModules = [ "security/pam.nix" ]; 
          }
          "${howdy}/nixos/modules/security/pam.nix"
          "${howdy}/nixos/modules/services/security/howdy"

          inputs.chaotic.nixosModules.default
        ];
      };

      diamondpcport = nixosSystem {
        inherit specialArgs;
        modules = laptop ++ [
          ./diamondpcport

          "${mod}/core/users.nix"
          "${mod}/core/lanzaboote.nix"

          "${mod}/programs/gamemode.nix"
          "${mod}/programs/hyprland"
          "${mod}/programs/games.nix"
          "${mod}/programs/zsh.nix"
          "${mod}/programs/home-manager.nix"

          "${mod}/network/syncthing.nix"

          "${mod}/services/kanata"
          "${mod}/services/gnome-services.nix"
          "${mod}/services/location.nix"

          "${mod}/nix"
          {
            home-manager = {
              users.diamantino.imports = homeImports."diamantino@diamondpcport";
              extraSpecialArgs = specialArgs;
              backupFileExtension = ".hm-backup";
            };
          }
        ];
      };
    };
}