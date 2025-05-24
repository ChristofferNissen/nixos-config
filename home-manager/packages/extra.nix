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
  # Define miscellaneous packages
  miscPackages = [
    appimage-run
    appimagekit
    arandr
    autorandr
    # bluez
    brightnessctl
    pamixer
    playerctl
    escrotum
    qmk_hid
  ];
in
{
  home.packages =
    (with pkgs; [
      signal-desktop
      bitwarden-desktop
      tidal-hifi
      discord
      vlc
    ])
    ++ (with unstable; [
      bitwarden-cli
    ])
    # Kubernetes (linux only)
    ++ (with unstable; [
      containerd
      nerdctl
      kaniko
    ])
    ++ miscPackages
    ++ hyprlandPackages;
}
