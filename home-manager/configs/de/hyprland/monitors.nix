{ nixosConfig, lib, ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        {
          output = nixosConfig.roles.desktop.monitor0.name;
          mode = nixosConfig.roles.desktop.monitor0.mode;
          # position = nixosConfig.roles.desktop.monitor1.position;
          scale = nixosConfig.roles.desktop.monitor0.scale;
          bitdepth = nixosConfig.roles.desktop.monitor0.bitdepth;
        }
        {
          output = nixosConfig.roles.desktop.monitor1.name;
          mode = nixosConfig.roles.desktop.monitor1.mode;
          # position = nixosConfig.roles.desktop.monitor1.position;
          scale = nixosConfig.roles.desktop.monitor1.scale;
          bitdepth = nixosConfig.roles.desktop.monitor1.bitdepth;
          vrr = nixosConfig.roles.desktop.monitor1.vrr;
          cm = nixosConfig.roles.desktop.monitor1.cm;
          sdrbrightness = nixosConfig.roles.desktop.monitor1.sdrbrightness;
          sdrsaturation = nixosConfig.roles.desktop.monitor1.sdrsaturation;
        }
      ] ++ lib.optional nixosConfig.roles.desktop.multimonitor
        {
          output = nixosConfig.roles.desktop.monitor2.name;
          mode = nixosConfig.roles.desktop.monitor2.mode;
          # position = nixosConfig.roles.desktop.monitor2.position;
          scale = nixosConfig.roles.desktop.monitor2.scale;
          bitdepth = nixosConfig.roles.desktop.monitor2.bitdepth;
          vrr = nixosConfig.roles.desktop.monitor2.vrr;
          cm = nixosConfig.roles.desktop.monitor2.cm;
          sdrbrightness = nixosConfig.roles.desktop.monitor2.sdrbrightness;
          sdrsaturation = nixosConfig.roles.desktop.monitor2.sdrsaturation;
        };
    };
  };
}
