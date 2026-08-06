{ ... }: {
  imports = [
    ./hyprland
    ./waybar
    ./walker.nix
    ./ghostty.nix

    ../../packages/extra.nix
  ];
}
