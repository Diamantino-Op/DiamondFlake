{
  description = "DiamondPC Flake configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    hyprlock.url = "github:hyprwm/hyprlock";

    hypridle.url = "github:hyprwm/hypridle";

    hyprpaper.url = "github:hyprwm/hyprpaper";

    hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";

    hyprcursor.url = "github:hyprwm/hyprcursor";
  };

  outputs = { self, nixpkgs, home-manager, hyprland } @ inputs:

  let 
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      
      config = {
        allowUnfree = true;
      };
    };

  in {
    homeConfigurations = {
      "diamantino@diamondpc" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        modules = [
          {
            wayland.windowManager.hyprland = {
              enable = true;

              # set the flake package
              package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
              portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
            };
          }
        ];
      };
    };

    nixosConfigurations = {
      diamondpc = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; inherit inputs; };

        modules = [
          ./nixos/configuration.nix
        ];
      };
    };
  };
}
