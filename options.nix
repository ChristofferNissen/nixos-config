{ lib, ... }:
{
  options = {
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
            default = "1.2";
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
            # default = "preferred";
            default = "5120x1440@239.76Hz";
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
            # default = "preferred";
            default = "5120x1440@239.76Hz";
            description = "Resolution and refresh rate for secondary monitor";
          };
          position = lib.mkOption {
            default = "0x0";
            description = "Position for secondary monitor";
          };
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
    };
  };
}

