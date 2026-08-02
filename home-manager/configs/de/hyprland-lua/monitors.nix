{ nixosConfig, lib, ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        {
          output = nixosConfig.roles.desktop.monitor1.name;
          mode = nixosConfig.roles.desktop.monitor1.mode;
          # position = nixosConfig.roles.desktop.monitor1.position;
          scale = nixosConfig.roles.desktop.monitor1.scale;
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
          vrr = nixosConfig.roles.desktop.monitor2.vrr;
          cm = nixosConfig.roles.desktop.monitor2.cm;
          sdrbrightness = nixosConfig.roles.desktop.monitor2.sdrbrightness;
          sdrsaturation = nixosConfig.roles.desktop.monitor2.sdrsaturation;
        };
    };
  };
}
