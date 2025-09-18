{ pkgs, unstable, inputs, ... }:

with pkgs;
let
  hyprlandPackages = [
    hyprland
    hypridle
    hyprlock
    hyprsunset
    inputs.hyprland-qtutils.packages."${pkgs.system}".default
    libinput
    libnotify
    wofi
    waybar
    kitty # required for the default Hyprland config
    pavucontrol
    seatd
  ];

  # Define miscellaneous packages
  miscPackages = [
    appimage-run
    # appimagekit
    arandr
    autorandr
    # bluez
    brightnessctl
    pamixer
    playerctl
    escrotum
    qmk_hid
    lynx
  ];
  neovimPackages = [ inotify-tools ];

in
{
  home.packages =
    (with pkgs; [ signal-desktop bitwarden-desktop tidal-hifi discord vlc ])
    ++ (with unstable; [ bitwarden-cli alacritty ])
    # Kubernetes (linux only)
    ++ (with unstable; [ containerd nerdctl kaniko ]) ++ miscPackages
    ++ neovimPackages ++ hyprlandPackages;
}
