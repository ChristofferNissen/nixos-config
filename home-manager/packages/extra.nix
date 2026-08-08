# Loaded from configs/de
{ pkgs
, unstable
, inputs
, ...
}:
let
  hyprlandPackages = with pkgs; [
    # inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
    # inputs.hyprlock.packages.${pkgs.stdenv.hostPlatform.system}.default
    # inputs.hypridle.packages.${pkgs.stdenv.hostPlatform.system}.default
    # inputs.hyprsunset.packages.${pkgs.stdenv.hostPlatform.system}.default
    # inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.default
    # inputs.hyprpwcenter.packages.${pkgs.stdenv.hostPlatform.system}.default
    # inputs.hyprpolkitagent.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.hyprland-qtutils.packages."${pkgs.stdenv.hostPlatform.system}".default
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    hyprland
    hyprlock
    hypridle
    hyprsunset
    hyprpaper
    hyprpwcenter
    hyprpolkitagent

    ladybird
    vivaldi
    vivaldi-ffmpeg-codecs

    wlr-randr
    wl-clipboard
    udiskie
    libinput
    libnotify
    waybar
    kitty # required for the default Hyprland config
    seatd
    # wofi
    # hyprshutdown
    rpcs3

  ];
  # Define miscellaneous packages
  miscPackages = with pkgs; [
    appimage-run
    # arandr
    # autorandr
    brightnessctl
    playerctl
    # pamixer
    # escrotum
    # qmk_hid
  ];
  programs = with pkgs; [
    signal-desktop
    bitwarden-desktop
    tidal-hifi
    # tidal-dl
    # high-tide
    # discord
    vlc
    # rpi-imager
    # retroarch-full
  ];
  programs_unstable = with unstable; [
    bitwarden-cli
    feishin
  ];
  kubernetesLinuxOnly = with unstable; [
    containerd
    nerdctl
    kaniko
  ];
  neovimLinuxOnlyPackages = with pkgs; [
    inotify-tools
    lynx
  ];
in
{
  home.packages =
    hyprlandPackages
    ++ programs
    ++ programs_unstable
    ++ kubernetesLinuxOnly
    ++ miscPackages
    ++ neovimLinuxOnlyPackages;
}
