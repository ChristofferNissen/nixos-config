{ pkgs, config, ... }:

{
  programs.hyprlock.enable = true;

  home.packages = with pkgs; [ wl-clipboard ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    systemd.variables = [ "--all" ];
    extraConfig = (builtins.readFile ./hypr/hyprland.conf);
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;
  };

  home.file."./.config/hypr" = {
    source = ./hypr;
    recursive = true;
  };

  home.file."./.config/waybar" = {
    source = ./waybar;
    recursive = true;
  };

  # Hyprland UWSM session variables
  # xdg.configFile."uwsm/env".source =
  #   "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

}
