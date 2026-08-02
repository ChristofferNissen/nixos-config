{ lib, pkgs, ... }:
{
  options = {
    # aquatic = {
    #   ntfyUrl = lib.mkOption {
    #     type = lib.types.str;
    #     default = "http://192.168.0.80:4351";
    #     description = "NTFY Server to use";
    #   };
    #
    #   path = lib.mkOption {
    #     default = "path:/home/aqua/AquaticOS";
    #     description = "Path to rebuild from";
    #   };
    #
    #   kernel = lib.mkOption {
    #     default = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
    #     description = "Kernel to use";
    #   };
    # };

    roles = {
      desktop = {
        enable = lib.mkEnableOption "Desktop role configuration";
        monitor0 = {
          name = lib.mkOption {
            default = "eDP-1";
            description = "Monitor to be used as the primary";
          };
          mode = lib.mkOption {
            # default = "highres";
            default = "preferred";
            description = "Resolution and refresh rate for primary monitor";
          };
          position = lib.mkOption {
            default = "auto";
            description = "Position for primary monitor";
          };
          scale = lib.mkOption {
            default = "1";
            description = "Scale for primary monitor";
          };
          bitdepth = lib.mkOption {
            default = 8;
            description = "Bitdepth for primary monitor";
          };
        };
        monitor1 = {
          name = lib.mkOption {
            default = "DP-2";
            description = "Monitor to be used as the primary";
          };
          mode = lib.mkOption {
            default = "preferred";
            description = "Resolution and refresh rate for primary monitor";
          };
          position = lib.mkOption {
            default = "0x0";
            description = "Position for primary monitor";
          };
          scale = lib.mkOption {
            default = "1";
            description = "Scale for primary monitor";
          };
          bitdepth = lib.mkOption {
            default = 10;
            description = "Bitdepth for primary monitor";
          };
          vrr = lib.mkOption {
            default = 1;
            description = "Variable Refresh Rate for primary monitor";
          };
          cm = lib.mkOption {
            default = "hdr";
            description = "Color Management for primary monitor";
          };
          sdrbrightness = lib.mkOption {
            default = "1.4";
            description = "SDR Brightness for primary monitor";
          };
          sdrsaturation = lib.mkOption {
            default = "1";
            description = "SDR Saturation for primary monitor";
          };
        };
        monitor2 = {
          name = lib.mkOption {
            default = "DP-3";
            description = "Monitor to be used as the secondary";
          };
          mode = lib.mkOption {
            default = "preferred";
            description = "Resolution and refresh rate for secondary monitor";
          };
          # position = lib.mkOption {
          #   default = "2561x0";
          #   description = "Position for secondary monitor";
          # };
          scale = lib.mkOption {
            default = "1";
            description = "Scale for secondary monitor";
          };
          bitdepth = lib.mkOption {
            default = 10;
            description = "Bitdepth for secondary monitor";
          };
          vrr = lib.mkOption {
            default = 1;
            description = "Variable Refresh Rate for secondary monitor";
          };
          cm = lib.mkOption {
            default = "hdr";
            description = "Color Management for secondary monitor";
          };
          sdrbrightness = lib.mkOption {
            default = "1.4";
            description = "SDR Brightness for secondary monitor";
          };
          sdrsaturation = lib.mkOption {
            default = "1";
            description = "SDR Saturation for secondary monitor";
          };
          side = lib.mkOption {
            default = "right";
            description = "Side of secondary monitor (right/left)";
          };
        };
        multimonitor = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "If second monitor should be in use";
        };
      };
      # gaming = {
      #   enable = lib.mkEnableOption "Gaming role configuration";
      # };
      #
      # ai = {
      #   enable = lib.mkEnableOption "AI role configuration";
      # };
      #
      # nixdev = {
      #   enable = lib.mkEnableOption "Nixdev role configuration";
      # };
    };

    # drivers = {
    #   vm = {
    #     enable = lib.mkEnableOption "Virtualbox Drivers";
    #   };
    #   bluetooth = {
    #     enable = lib.mkEnableOption "Bluetooth Drivers";
    #   };
    #   gpu.amd = {
    #     enable = lib.mkEnableOption "AMD Gpu Drivers";
    #   };
    # };

  };
}

