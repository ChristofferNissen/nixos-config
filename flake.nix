{
  description = "NixOS and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";
  };

  outputs = { self, nixpkgs, home-manager, hyprland-qtutils,  ... }@inputs:
  let
    userName = "cn";
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      x1 = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          {
            users.users.${userName} = {
              isNormalUser = true;
              description = "Christoffer Nissen";
              extraGroups = [
                "networkmanager"
                "wheel"
                "docker"
              ];
              home = "/home/${userName}";
            };
          }

          ./nixos/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit inputs; inherit userName; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${userName} = import ./home-manager/home.nix;
          }
 
        ];
      };
    };
  };
}
