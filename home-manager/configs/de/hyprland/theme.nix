{
  wayland.windowManager.hyprland = {
    settings = {
      config = {
        decoration = {
          rounding = 10;
          active_opacity = 1.0;
          inactive_opacity = 0.9;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };
        };
      };
      env = [
        { _args = [ "XCURSOR_SIZE" "24" ]; }
        { _args = [ "HYPRCURSOR_SIZE" "24" ]; }
      ];
    };
  };
}
