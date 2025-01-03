{ pkgs, system, inputs, ... }:

with pkgs;
let
  hyprlandPackages = [ 
    hyprland
    hypridle
    hyprlock
    hyprsunset
    inputs.hyprland-qtutils.packages."${pkgs.system}".default
    wofi
    waybar
    kitty # required for the default Hyprland config
  ];
in
{
  home.packages =
    with pkgs;
    [
      signal-desktop
      bitwarden-desktop
      tidal-hifi
      discord
    ]
    ++ hyprlandPackages;
}
