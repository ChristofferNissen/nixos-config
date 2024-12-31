{
  description = "NixOS and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-qtutils = {
      url = "github:hyprwm/hyprland-qtutils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland-qtutils,  ... }@inputs:
  let
    userName = "cn";
    description = "Christoffer Nissen";
    system = "x86_64-linux";
    stateVersion = "24.11";
  in {
    nixosConfigurations = {
      x1 = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          # Create user
          {
            users.users.${userName} = {
              isNormalUser = true;
              description = description;
              extraGroups = [
                "networkmanager"
                "wheel"
                "docker"
              ];
              home = "/home/${userName}";
            };
          }

          # Create NixOS
          ./nixos/configuration.nix

          # Create home folder
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { 
              inherit inputs; inherit userName; inherit stateVersion;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${userName} = import ./home-manager/home.nix;
          }
        ];
      };
    };
  };
}
