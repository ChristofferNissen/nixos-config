{ lib, ... }:
let
  lua = lib.generators.mkLuaInline;
in
{
  wayland.windowManager.hyprland = {
    settings = {
      on = {
        _args = [
          "hyprland.start"
          (lua ''
            function()
              hl.exec_cmd("bash -c \"wl-paste --watch cliphist store &\"")
              hl.exec_cmd("dms run")
              hl.exec_cmd("systemctl --user start hyperpolkitagent")
              hl.exec_cmd("waybar")
              hl.exec_cmd("elephant")
              hl.exec_cmd("signal-desktop")
              hl.exec_cmd("bitwarden")
              hl.exec_cmd("hyprpaper")
            end
          '')
        ];
      };
    };
  };
}
