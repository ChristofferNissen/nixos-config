{ inputs, pkgs, ... }: {
  home.packages = with pkgs; [
    hyprland
    hypridle
    hyprlock
    hyprsunset
    hyprpwcenter
    hyprpaper
    hyprpolkitagent
    wl-clipboard
    udiskie
    inputs.hyprland-qtutils.packages."${stdenv.hostPlatform.system}".default
    libinput
    libnotify
    waybar
    kitty # required for the default Hyprland config
    seatd
    # wofi
    # hyprshutdown
  ];
}
