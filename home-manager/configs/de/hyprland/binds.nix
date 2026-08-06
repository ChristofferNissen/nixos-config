{ lib, ... }:
let
  lua = lib.generators.mkLuaInline;
  mainMod = "SUPER";

  dsp = {
    exec = cmd: lua ''hl.dsp.exec_cmd("${cmd}")'';
    close = lua "hl.dsp.window.close()";
    fullscreen = lua "hl.dsp.window.fullscreen()";
  };

  bind = keys: dispatcher: {
    _args = [
      keys
      dispatcher
    ];
  };
in
{
  wayland.windowManager.hyprland = {
    settings = {
      # bindm = [
      #   # Move/resize windows with mod + LMB/RMB and dragging
      #   "$mod, mouse:272, movewindow"
      #   "$mod, mouse:273, resizewindow"
      # ];
      # bindl = [
      #   " , switch:on:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, disable\""
      #   " , switch:off:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, enable\""
      # ];
      bind = [
        # Actions
        (bind "${mainMod} + Return" (dsp.exec "ghostty"))
        (bind "${mainMod} + SHIFT + Return" (dsp.exec "zen"))
        (bind "${mainMod} + SHIFT + W" dsp.close)
        (bind "${mainMod} + SHIFT + E" (dsp.exec "dms ipc call powermenu toggle"))
        (bind "${mainMod} + F" dsp.fullscreen)
        (bind "${mainMod} + Space" (dsp.exec "walker drun"))
        (bind "Print" (dsp.exec "grim -g \\\"$(slurp)\\\" - | wl-copy"))

        # (bind "SHIFT + Print" (dsp.exec "grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') - | wl-copy"))
        # (bind "${mainMod} + grave" (dsp.exec "$HOME/.config/hypr/scripts/hdrop.sh --floating --gap $outerGap --class ddownkit kitty --class ddownkit"))
        # (bind "${mainMod} + ALT + grave" (dsp.exec "$HOME/.config/hypr/scripts/hdrop.sh --floating --gap $outerGap --class ddownfiles kitty --class ddownfiles yazi"))
        # (bind "${mainMod} + C" (dsp.exec "$HOME/.config/hypr/scripts/goxlrMute.sh"))

        (bind "XF86AudioRaiseVolume" (dsp.exec "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"))
        (bind "XF86AudioLowerVolume" (dsp.exec "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"))
        (bind "XF86AudioMute" (dsp.exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
        (bind "XF86AudioMicMute" (dsp.exec "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
        (bind "XF86MonBrightnessUp" (dsp.exec "brightnessctl set 10%+"))
        (bind "XF86MonBrightnessDown" (dsp.exec "brightnessctl set 10%-"))

        (bind "XF86AudioNext" (dsp.exec "playerctl next"))
        (bind "XF86AudioPause" (dsp.exec "playerctl play-pause"))
        (bind "XF86AudioPlay" (dsp.exec "playerctl play-pause"))
        (bind "XF86AudioPrev" (dsp.exec "playerctl previous"))
      ];
    };
  };
}
