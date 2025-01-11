{ inputs, pkgs, ... }:

{
  home.packages = [
    inputs.ghostty.packages."x86_64-linux".default
  ];

  # catppuccin.ghostty = {
  #   enable = true;
  # };
}
