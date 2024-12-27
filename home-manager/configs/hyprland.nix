{
  programs.kitty.enable = true; # required for the default Hyprland config
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = ''
      $mainMod, F, exec, firefox
    '';
    # settings = {
    #   "$mod" = "SUPER";
    #   bind = [
    #     "$mod, Q, exec, kitty"
    #     "$mod, F, exec, firefox"
    #     "$mod, C, killactive,"
    #     "$mod, M, exit,"
    #     "$mod, E, exec, nautilus"
    #     "$mod, V, togglefloating,"
    #     "$mod, R, exec, wofi --show drun"
    #     "$mod, P, pseudo,"
    #     "$mod, J, togglesplit,"
    #     "$mod, left, movefocus, l"
    #     "$mod, right, movefocus, r"
    #     "$mod, up, movefocus, u"
    #     "$mod, down, movefocus, d"
    #     "$mod, S, togglespecialworkspace, magic"
    #     "$mod SHIFT, S, movetoworkspace, special:magic"
    #     "$mod, mouse_down, workspace, e+1"
    #     "$mod, mouse_up, workspace, e-1"
    #     "$mod, mouse:272, movewindow"
    #     "$mod, mouse:273, resizewindow"
    #     ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
    #     ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    #     ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    #     ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    #     ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
    #     ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
    #     ", XF86AudioNext, exec, playerctl next"
    #     ", XF86AudioPause, exec, playerctl play-pause"
    #     ", XF86AudioPlay, exec, playerctl play-pause"
    #     ", XF86AudioPrev, exec, playerctl previous"
    #   ] ++ (
    #     # workspaces
    #     # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
    #     builtins.concatLists (builtins.genList (i:
    #         let ws = i + 1;
    #         in [
    #           "$mod, code:1${toString i}, workspace, ${toString ws}"
    #           "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
    #         ]
    #       )
    #       9)
    #   );
    # };
  };

  home.file."./.config/hypr/" = {
    source = ./hyprland;
    recursive = true;
  };
}
