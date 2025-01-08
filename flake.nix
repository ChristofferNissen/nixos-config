{
  description = "NixOS and Home Manager configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs?ref=nixos-24.11";
    };

    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs?ref=master";
    };

    # ref: https://github.com/NixOS/nixos-hardware/tree/master
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-qtutils = {
      url = "github:hyprwm/hyprland-qtutils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      hyprland-qtutils,
      catppuccin,
      ...
    }@inputs:
    let
      userName = "cn";
      description = "Christoffer Nissen";
      system = "x86_64-linux";
      stateVersion = "24.11";
    in
    {
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

            # ref: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen

            # Create NixOS
            ./hosts/nixos/configuration.nix

            # Create home folder
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit userName;
                inherit stateVersion;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${userName} = import ./home-manager/home.nix;
            }
          ];
        };
        wsl = nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = { inherit inputs system userName; };
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
              system.stateVersion = stateVersion;
            }

            # Create User
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

            # basic configuration
            ./hosts/wsl/configuration.nix

            # Create home folder
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit
                  inputs
                  system
                  userName
                  stateVersion
                  ;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${userName} = import ./home-manager/wsl.nix;
            }
          ];
        };
      };
    };
}
