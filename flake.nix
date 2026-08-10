{
  description = "NixOS and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/release-26.05";
    # nixpkgs-unstable = {
    #   url = "github:NixOS/nixpkgs?ref=master";
    # };
    nixpkgs-unstable.follows = "nixpkgs";

    # ref: https://github.com/NixOS/nixos-hardware/tree/master
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    # nixvim.url = "github:nix-community/nixvim";
    # nixvim.url = "github:nix-community/nixvim/nixos-26.05";

    # Personal Neovim configuration
    # For local development this points at the working tree. After pushing the
    # repo, switch to: url = "github:ChristofferNissen/nixvim-config"
    # nixvim-config = {
    #   url = "git+file:///home/cn/configs/nixvim-config";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # ref: https://github.com/nix-community/NixOS-WSL/
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs-unstable";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    # home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    # hyprland.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # hyprsunset.url = "github:hyprwm/hyprsunset";
    # hyprsunset.inputs.nixpkgs.follows = "hyprland";
    # hyprsunset.inputs.systems.follows = "hyprland/systems";
    # hyprlock.url = "github:hyprwm/hyprlock";
    # hyprlock.inputs.nixpkgs.follows = "hyprland";
    # hyprlock.inputs.systems.follows = "hyprland/systems";
    # hyprpaper.url = "github:hyprwm/hyprpaper";
    # hyprpaper.inputs.nixpkgs.follows = "hyprland";
    # hyprpaper.inputs.systems.follows = "hyprland/systems";
    # hypridle.url = "github:hyprwm/hypridle";
    # hypridle.inputs.nixpkgs.follows = "hyprland";
    # hypridle.inputs.systems.follows = "hyprland/systems";
    # hyprpolkitagent.url = "github:hyprwm/hypridle";
    # hyprpolkitagent.inputs.nixpkgs.follows = "hyprland";
    # hyprpolkitagent.inputs.systems.follows = "hyprland/systems";
    # hyprpwcenter.url = "github:hyprwm/hyprpwcenter";
    # hyprpwcenter.inputs.nixpkgs.follows = "hyprland";
    # hyprpwcenter.inputs.systems.follows = "hyprland/systems";

    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";
    # hyprland-qtutils.inputs.nixpkgs.follows = "hyprland";
    # hyprland-qtutils.inputs.systems.follows = "hyprland/systems";

    catppuccin.url = "github:catppuccin/nix";

    ghostty.url = "github:ghostty-org/ghostty";
    # ghostty.inputs.nixpkgs.follows = "nixpkgs-unstable";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs-unstable";

    nixgl.url = "github:nix-community/nixGL";

    elephant.url = "github:abenz1267/elephant";
    walker.url = "github:abenz1267/walker";
    walker.inputs.elephant.follows = "elephant";
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
      nixpkgs-config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
        permittedInsecurePackages = [ "electron-39.8.10" ];
      };
    in
    {
      darwinConfigurations =
        let
          system = "aarch64-darwin"; # Change to "x86_64-darwin" if needed
          unstable = import nixpkgs-unstable {
            inherit system;
            config = nixpkgs-config;
          };
          pkgs = import nixpkgs {
            inherit system;
            config = nixpkgs-config;
          };
        in
        {
          mac = darwin.lib.darwinSystem {
            system = system;
            specialArgs = { inherit inputs; };
            modules = [
              {
                users.users.${userName} = {
                  home = "/Users/${userName}";
                };
              }

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
          };
        };
      nixosConfigurations =
        let
          system = "x86_64-linux";
          unstable = import nixpkgs-unstable {
            inherit system;
            config = nixpkgs-config;
          };
          pkgs = import nixpkgs {
            inherit system;
            config = nixpkgs-config;
          };
        in
        {
          x1 = nixpkgs.lib.nixosSystem {
            system = system;
            specialArgs = {
              inherit
                inputs
                userName
                description
                ;
            };
            modules = [
              ./hosts/common/lix.nix
              ./hosts/common/user.nix

              ./options.nix

              # NixOS
              ./hosts/x1/configuration.nix

              # ref: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
              nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen

              # Create home folder
              home-manager.nixosModules.home-manager
              {
                home-manager.extraSpecialArgs = {
                  inherit
                    inputs
                    unstable
                    pkgs
                    userName
                    stateVersion
                    ;
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
              inherit
                # inputs
                # nixos-wsl
                # system
                userName
                description
                ;
            };
            modules = [
              ./hosts/wsl/configuration.nix
              ./hosts/common/user.nix
              ./hosts/common/lix.nix

              # WSL configuration
              nixos-wsl.nixosModules.default
              {
                wsl.enable = true;
                wsl.defaultUser = userName;
                wsl.wslConf.automount.enabled = true;
                wsl.wslConf.boot.systemd = true;
                wsl.wslConf.network.generateResolvConf = false;
                wsl.useWindowsDriver = true; # Allow WSL to talk to Windows GPU drivers
                wsl.wslConf.wsl2 = {
                    memory = "24GB";
                    swap = "16GB";
                };
                # Optional but recommended for AI workflows
                # wsl.wslConf.experimental = {
                #     autoMemoryReclaim = "gradual";
                # };
                networking.nameservers = [
                  "10.41.2.10"
                  "10.41.2.11"
                  "10.41.18.10"
                ];
                system.stateVersion = stateVersion;
              }

              # Create home folder
              home-manager.nixosModules.home-manager
              {
                home-manager.extraSpecialArgs = {
                  inherit
                    inputs
                    unstable
                    pkgs
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
