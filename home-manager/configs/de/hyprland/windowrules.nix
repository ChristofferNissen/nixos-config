let
  games = "^(steam_app_.*|gamescope|tf_linux64|.*\\.exe|.*Tabletop.*|Terraria.*|tf2classified_linux64|.*elltaker_lnx.x86_64|hl2_linux|DyingLightGame|Buckshot.*|factorio)$";
  browsers = "^(zen|zen-beta|floorp|firedragon)$";
in
{
  wayland.windowManager.hyprland = {
    settings = {
      window_rule = [
        # Opacity Rules
        { match = { class = ".*"; }; opacity = "0.94"; }
        { match = { class = browsers; }; opacity = "1"; }
        { match = { content = "game"; }; opacity = "1"; }
        { match = { content = "video"; }; opacity = "1"; }
        { match = { class = "vesktop"; }; opacity = "1"; }

        # Focus Restrictions
        { match = { class = browsers; }; suppress_event = "activatefocus"; }

        # Misc Rules
        { match = { class = games; }; fullscreen = true; }

        # Content Tags
        { match = { class = games; }; content = "game"; }
        { match = { title = "Parsec"; }; content = "game"; }
        { match = { class = "org.jellyfin.JellyfinDesktop"; }; content = "video"; }

        # Workspace 1X Rules
        { match = { class = "^(zen|zen-beta)$"; }; workspace = "11 silent"; }
        { match = { class = games; }; workspace = "12"; }
        { match = { class = "org.jellyfin.JellyfinDesktop"; }; workspace = "13"; }
        { match = { class = "org.openrgb.OpenRGB"; }; workspace = "13 silent"; }
        { match = { class = "^(floorp|firedragon)$"; }; workspace = "19 silent"; }

        # Workspace 2X Rules
        { match = { class = "steam"; }; workspace = "22 silent"; }
        { match = { class = "heroic"; }; workspace = "22 silent"; }
        { match = { class = "stoat-desktop"; }; workspace = "23 silent"; }
        { match = { class = "vesktop"; }; workspace = "24 silent"; }
        { match = { class = "signal"; }; workspace = "25 silent"; }
        { match = { class = "thunderbird"; }; workspace = "26 silent"; }
        { match = { class = "com.saivert.pwvucontrol"; }; workspace = "27 silent"; }

        # GIMP Fixes
        { match = { initial_class = "^(gimp)$"; initial_title = "^(Change .* Color)$"; }; no_initial_focus = true; }
        { match = { initial_class = "^(gimp)$"; }; opacity = "1"; }
        { match = { initial_class = "^(gimp)$"; initial_title = "^(Change .* Color)$"; }; suppress_event = "urgent"; }
      ];
    };
  };
}