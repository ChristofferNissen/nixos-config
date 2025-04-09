{
  pkgs,
  inputs,
  ...
}:

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
    pavucontrol
    seatd
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
