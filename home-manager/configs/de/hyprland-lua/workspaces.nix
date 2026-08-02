{ lib, nixosConfig, ... }:
let
  lua = lib.generators.mkLuaInline;
  mainMod = "SUPER";

  # mon1 = nixosConfig.roles.desktop.monitor1.name;
  # mon2 = nixosConfig.roles.desktop.monitor2.name;

  dsp = {
    workspace = ws: lua ''hl.dsp.focus({ workspace = "${toString ws}" })'';
    moveToWorkspaceSilent = ws: lua ''hl.dsp.window.move({ workspace = "${toString ws}", silent = true })'';
  };

  bind = keys: dispatcher: { _args = [ keys dispatcher ]; };

  workspacecount = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" ];
  # secondMonKey = if nixosConfig.roles.desktop.monitor2.side == "right" then "ALT"
  #   else if nixosConfig.roles.desktop.monitor2.side == "left" then "CONTROL"
  #   else "ALT";
in
{
  wayland.windowManager.hyprland = {
    settings = {
      # workspace_rule = [
      #   { workspace = "11"; monitor = mon1; default = true; }
      #   { workspace = "12"; monitor = mon1; }
      #   { workspace = "13"; monitor = mon1; }
      #   { workspace = "14"; monitor = mon1; }
      #   { workspace = "15"; monitor = mon1; }
      #   { workspace = "16"; monitor = mon1; }
      #   { workspace = "17"; monitor = mon1; }
      #   { workspace = "18"; monitor = mon1; }
      #   { workspace = "19"; monitor = mon1; }
      #
      #   { workspace = "21"; monitor = mon2; default = true; }
      #   { workspace = "22"; monitor = mon2; }
      #   { workspace = "23"; monitor = mon2; }
      #   { workspace = "24"; monitor = mon2; }
      #   { workspace = "25"; monitor = mon2; }
      #   { workspace = "26"; monitor = mon2; }
      #   { workspace = "27"; monitor = mon2; }
      #   { workspace = "28"; monitor = mon2; }
      #   { workspace = "29"; monitor = mon2; }
      # ];

      bind =
        lib.imap1 (i: v: bind "${mainMod} + ${v}" (dsp.workspace "1${toString i}")) workspacecount
        ++ lib.imap1 (i: v: bind "${mainMod} + SHIFT + ${v}" (dsp.moveToWorkspaceSilent "1${toString i}")) workspacecount;
        # ++ lib.imap1 (i: v: bind "${mainMod} + ${secondMonKey} + ${v}" (dsp.workspace "2${toString i}")) workspacecount
        # ++ lib.imap1 (i: v: bind "${mainMod} + ${secondMonKey} + SHIFT + ${v}" (dsp.moveToWorkspaceSilent "2${toString i}")) workspacecount;
    };
  };
}
