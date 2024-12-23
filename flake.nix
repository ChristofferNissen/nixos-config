{
  description = "NixOS and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      x1 = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          {
            users.users.cn = {
              isNormalUser = true;
              description = "Christoffer Nissen";
              extraGroups = [
                  "networkmanager"
                  "wheel"
              ];
              home = "/home/cn";
            };
          }
          
          ./nixos/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.cn = import ./home-manager/home.nix;
          }
        ];
      };
    };
  };
}
