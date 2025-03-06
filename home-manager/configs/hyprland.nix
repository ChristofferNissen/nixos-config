{ config, pkgs, lib, ... }:


{
  programs.hyprlock.enable = true;

  home.packages = with pkgs; [
      wl-clipboard
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    systemd.variables = [
      "--all"
    ];

    extraConfig = (builtins.readFile ./hypr/hyprland.conf);
  };

  home.file."./.config/hypr" = {
    source = ./hypr;
    recursive = true;
  };

  home.file."./.config/waybar" = {
    source = ./waybar;
    recursive = true;
  };
}
