{
  programs.kitty.enable = true; # required for the default Hyprland config
  programs.hyprlock.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = (builtins.readFile ./hyprland/hyprland.conf);
  };
}
