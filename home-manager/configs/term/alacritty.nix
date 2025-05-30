{ pkgs, userName, ... }:

{
  catppuccin.alacritty.enable = true;
  programs.alacritty = {
    enable = true;
    settings = {
      #keybindings = [
      #  { key = "Equals";     mods = "Control";     action = "IncreaseFontSize"; }
      #  { key = "Add";        mods = "Control";     action = "IncreaseFontSize"; }
      #  { key = "Subtract";   mods = "Control";     action = "DecreaseFontSize"; }
      #  { key = "Minus";      mods = "Control";     action = "DecreaseFontSize"; }
      #];

      window = {
        title = "Terminal";

        padding = { y = 5; };

        dimensions = {
          lines = 75;
          columns = 100;
        };
      };

      font = {
        size = 12;
        normal = {
          # family = "JetBrains Mono Nerd Font";
          family = "Fira Code";
          style = "Regular";
        };
        bold = {
          # family = "JetBrains Mono Nerd Font";
          family = "Fira Code";
          style = "Bold";
        };
        italic = {
          # family = "JetBrains Mono Nerd Font";
          family = "Fira Code";
          style = "Italic";
        };
        bold_italic = {
          # family = "JetBrains Mono Nerd Font";
          family = "Fira Code";
          style = "Bold Italic";
        };
      };

      terminal.shell = {
        program = "/etc/profiles/per-user/${userName}/bin/zsh";
      };
    };
  };
}
