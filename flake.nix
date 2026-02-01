{
  description = "NixOS and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable = { url = "github:NixOS/nixpkgs?ref=master"; };

    # ref: https://github.com/NixOS/nixos-hardware/tree/master
    nixos-hardware = { url = "github:NixOS/nixos-hardware/master"; };

    # ref: https://github.com/nix-community/NixOS-WSL/
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs-unstable";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";

    hyprland-qtutils = {
      url = "github:hyprwm/hyprland-qtutils";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    catppuccin.url = "github:catppuccin/nix";

    ghostty.url = "github:ghostty-org/ghostty";
    ghostty.inputs.nixpkgs.follows = "nixpkgs-unstable";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    nixgl.url = "github:nix-community/nixGL";

    # ladybird.url = "github:LadybirdBrowser/ladybird";

    elephant.url = "github:abenz1267/elephant";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };
  };

  outputs =
    { nixpkgs
    , nixpkgs-unstable
    , nixos-hardware
    , nixos-wsl
    , darwin
    , home-manager
    , ...
    }@inputs:
    let
      userName = "cn";
      description = "Christoffer Nissen";
      stateVersion = "24.11";
    in
    {
      darwinConfigurations =
        let
          system = "aarch64-darwin"; # Change to "x86_64-darwin" if needed
          unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        {
          mac = darwin.lib.darwinSystem {
            system = system;
            modules = [
              { users.users.${userName} = { home = "/Users/${userName}"; }; }

              ./hosts/mac/darwin-configuration.nix
              ./hosts/common/lix.nix

              home-manager.darwinModules.home-manager
              {
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                  inherit system;
                  inherit unstable;
                  inherit pkgs;
                  inherit userName;
                  inherit stateVersion;
                };
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${userName} = import ./home-manager/mac.nix;
              }
            ];
            specialArgs = { inherit inputs; };
          };
        };
      nixosConfigurations =
        let
          system = "x86_64-linux";
          unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        {
          x1 = nixpkgs.lib.nixosSystem {
            system = system;
            specialArgs = { inherit inputs system userName description; };
            modules = [
              {
                nixpkgs = {
                  config = {
                    allowUnfree = true;
                    allowUnfreePredicate = (_: true);
                  };
                };
              }
              # Create user
              ./hosts/common/user.nix

              # ref: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
              nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen

              # NixOS
              ./hosts/x1/configuration.nix
              ./hosts/common/lix.nix

              # Create home folder
              home-manager.nixosModules.home-manager
              {
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                  inherit unstable;
                  inherit pkgs;
                  inherit userName;
                  inherit stateVersion;
                };
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${userName} = import ./home-manager/linux.nix;
              }
            ];
          };
          wsl = nixpkgs.lib.nixosSystem {
            system = system;
            specialArgs = {
              inherit inputs nixos-wsl system userName description;
            };
            modules = [
              # Create User
              ./hosts/common/user.nix

              # basic configuration
              ./hosts/wsl/configuration.nix
              ./hosts/common/lix.nix

              # WSL specific configuration
              nixos-wsl.nixosModules.default
              {
                system.stateVersion = stateVersion;
                wsl.enable = true;
                wsl.defaultUser = userName;

                # WSL Configuration
                wsl.wslConf.automount.enabled = true;
                wsl.wslConf.boot.systemd = true;
                wsl.wslConf.network.generateResolvConf = false;
                networking.nameservers =
                  [ "10.41.2.10" "10.41.2.11" "10.41.18.10" ];
              }

              # Create home folder
              home-manager.nixosModules.home-manager
              {
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                  inherit unstable;
                  inherit pkgs;
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
