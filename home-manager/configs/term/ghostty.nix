{ inputs, ... }:

{
  home.packages = [ inputs.ghostty.packages."x86_64-linux".default ];

  home.file."./.config/ghostty/config".text = ''
    theme = "dark:catppuccin-mocha,light:catppuccin-latte"
    font-family = "Fira Code"
    font-size = 12
    shell-integration-features = no-cursor
    cursor-style = block
    window-decoration = false
    command = "/run/current-system/sw/bin/zsh"
  '';

}
