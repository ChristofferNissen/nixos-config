{ pkgs, unstable, inputs, ... }:

let
  # Define miscellaneous packages
  miscPackages = with pkgs; [
    appimage-run
    arandr
    autorandr
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
    tidal-dl
    high-tide
    discord
    vlc
    # lidarr
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  programs_unstable = with unstable; [ bitwarden-cli alacritty ];
  kubernetesLinuxOnly = with unstable; [ containerd nerdctl kaniko ];
  neovimLinuxOnlyPackages = with pkgs; [ inotify-tools lynx ];
in
{
  home.packages = programs ++ programs_unstable ++ kubernetesLinuxOnly
    ++ miscPackages ++ neovimLinuxOnlyPackages;
}
