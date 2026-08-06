{ inputs, pkgs, lib, config, ... }:
{
  # Hyprland UWSM session variables
  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

  wayland.windowManager.hyprland = {
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    settings = {
      config = {
        dwindle = {
            preserve_split = true;
        };
        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          # col = {
          #   active_border = lib.generators.mkLuaInline "colors.mauve";
          #   inactive_border = lib.generators.mkLuaInline "colors.overlay0";
          # };
          layout = "dwindle";
          resize_on_border = true;
          allow_tearing = false;
        };

        render = {
          # direct_scanout = 2;
        };

        xwayland = {
            force_zero_scaling = true;
        };

        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };
        };

        misc = {
          focus_on_activate = true;

          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          # on_focus_under_fullscreen = 1;
        };
      };
    };
  };
}
