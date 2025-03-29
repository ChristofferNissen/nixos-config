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

    # ref: https://github.com/nix-community/NixOS-WSL/
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
      #inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprland-qtutils = {
      url = "github:hyprwm/hyprland-qtutils";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    catppuccin.url = "github:catppuccin/nix";

    ghostty.url = "github:ghostty-org/ghostty";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    # ladybird.url = "github:LadybirdBrowser/ladybird";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixos-hardware,
      nixos-wsl,
      home-manager,
      hyprland-qtutils,
      catppuccin,
      ghostty,
      zen-browser,
      # ladybird,
      ...
    }@inputs:
    let
      userName = "cn";
      description = "Christoffer Nissen";
      system = "x86_64-linux";
      stateVersion = "24.11";
      unstable = import nixpkgs-unstable { inherit system; };
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
                inherit unstable;
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
          specialArgs = {
            inherit
              inputs
              nixos-wsl
              system
              userName
              ;
          };
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

            # wsl specific configuration
            nixos-wsl.nixosModules.default
            {
              system.stateVersion = stateVersion;
              wsl.enable = true;
              wsl.defaultUser = userName;

              # WSL Configuration
              wsl.wslConf.automount.enabled = true;

              wsl.wslConf.boot.command = "neofetch";
              wsl.wslConf.boot.systemd = true;

              wsl.wslConf.network.generateResolvConf = true;
            }

            # Create home folder
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit unstable;
                inherit system;
                inherit userName;
                inherit stateVersion;
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
