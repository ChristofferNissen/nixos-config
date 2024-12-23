{ pkgs, lib, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = rec {
      modifier = "Mod4";
      bars = [ ];

      window.border = 0;

      fonts = {
        names = ["DejaVu Sans Mono, FontAwesome 8"];
        size = 10.0;
      };

      gaps = {
        inner = 10;
        outer = 5;
      };

      keybindings = lib.mkOptionDefault {
        "XF86AudioMute" = "exec amixer set Master toggle";
        "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
        "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 4%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 4%+";
        "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${modifier}+Shift+Return" = "exec ${pkgs.firefox}/bin/firefox";
        "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -modi drun -show drun";
        "${modifier}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi -show window";
        "${modifier}+b" = "exec ${pkgs.brave}/bin/brave";
        "${modifier}+Shift+x" = "exec systemctl suspend";
        "${modifier}+Shift+z" = "mode \"$keyboard_layout\"";
      };

      startup = [
        {
          command = "exec i3-msg workspace 1";
          always = true;
          notification = false;
        }
        {
          command = "systemctl --user restart polybar.service";
          always = true;
          notification = false;
        }
        {
          command = "${pkgs.feh}/bin/feh --bg-scale ~/background.png";
          always = true;
          notification = false;
        }
      ];
    };

    # Extra config from Fedora workstation
    extraConfig = ''
      set $keyboard_layout Keyboard Layout: (d) Danish, (e) US English, (esc) Cancel
      mode "$keyboard_layout" {
        bindsym d exec --no-startup-id setxkbmap dk, mode "default"
        bindsym e exec --no-startup-id setxkbmap us, mode "default"
        bindsym Escape mode "default"
      }
    '';

  };
}
