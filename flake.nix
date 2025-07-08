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

    darwin.url = "github:LnL7/nix-darwin";

    home-manager.url = "github:nix-community/home-manager";

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
          unstable = import nixpkgs-unstable { inherit system; };
        in
        {
          mac = darwin.lib.darwinSystem {
            system = system;
            modules = [

              { users.users.${userName} = { home = "/Users/${userName}"; }; }

              ./hosts/mac/darwin-configuration.nix

              home-manager.darwinModules.home-manager
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
                home-manager.users.${userName} = import ./home-manager/mac.nix;
              }

            ];
            specialArgs = { inherit inputs; };
          };
        };
      nixosConfigurations =
        let
          system = "x86_64-linux";
          unstable = import nixpkgs-unstable { inherit system; };
        in
        {
          x1 = nixpkgs.lib.nixosSystem {
            system = system;
            modules = [

              # Create user
              {
                users.users.${userName} = {
                  isNormalUser = true;
                  description = description;
                  extraGroups = [ "networkmanager" "wheel" "docker" ];
                  home = "/home/${userName}";
                };
              }

              # ref: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
              nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen

              # Create NixOS
              {
                nixpkgs = {
                  config = {
                    allowUnfree = true;
                    allowUnfreePredicate = (_: true);
                  };
                };
              }
              ./hosts/x1/configuration.nix

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
                home-manager.users.${userName} = import ./home-manager/linux.nix;
              }

            ];
          };
          wsl = nixpkgs.lib.nixosSystem {
            system = system;
            specialArgs = { inherit inputs nixos-wsl system userName; };
            modules = [

              # Create User
              {
                users.users.${userName} = {
                  isNormalUser = true;
                  description = description;
                  extraGroups = [ "networkmanager" "wheel" "docker" ];
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
