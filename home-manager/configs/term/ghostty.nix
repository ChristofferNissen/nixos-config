{ inputs, ... }:

{
  home.packages = [ inputs.ghostty.packages."x86_64-linux".default ];

  home.file."./.config/ghostty/config".text = ''
    theme = "dark:Catppuccin Mocha,light:Catppuccin Latte"
    font-family = "Fira Code"
    font-size = 12
    shell-integration-features = no-cursor
    cursor-style = block
    window-decoration = false
    command = "/run/current-system/sw/bin/zsh"
  '';

}
