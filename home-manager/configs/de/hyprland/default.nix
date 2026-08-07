{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.configType = "lua";
  wayland.windowManager.hyprland.systemd.enable = false;
  imports = [
    ./animations.nix
    ./autostart.nix
    ./binds.nix
    ./environments.nix
    ./general.nix
    ./input.nix
    ./layouts.nix
    ./monitors.nix
    ./theme.nix
    # ./windowrules.nix
    ./workspaces.nix
    ./services
  ];
}
