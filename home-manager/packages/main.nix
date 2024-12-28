{ pkgs, system, inputs, ... }:

with pkgs;
let
  # Define the default Kubernetes packages
  defaultKubernetes = [
    k9s
    kubectl
    kind
    kubernetes-helm
    oras
    skopeo
    docker
  ];

  # Define the default Python packages
  defaultPython = python3.withPackages (
    python-packages: with python-packages; [
      black
      flake8
      setuptools
      wheel
      twine
      virtualenv
    ]
  );

  # Define miscellaneous packages
  miscPackages = [
    appimage-run
    appimagekit
    arandr
    autorandr
    tmate
    bluez
    brightnessctl
  ];

  # Define terminal-related packages
  terminalPackages = [
    alacritty
    any-nix-shell
    neofetch
    zip
    unzip
    escrotum
    tree
    gnupg
    aria2
    imagemagick
    feh
    gotop
    htop
    zsh
    oh-my-zsh
    fzf
    thefuck
    yq
    jq
    neofetch
  ];

  # Define development-related packages
  developmentPackages = [
    vim
    go
    jetbrains.goland
    go-task
  ];

  qmkPackages = [
    qmk
    qmk_hid
  ];

  neovimPackages = [ 
    # neovim
    # (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

in
{
  home.packages =
    with pkgs;
    [
      signal-desktop
      bitwarden-desktop
      home-manager
      tidal-hifi
      discord
      hyprland
      inputs.hyprland-qtutils.packages."${pkgs.system}".default
      wofi
      waybar
    ]
    ++ defaultKubernetes
    ++ miscPackages
    ++ terminalPackages
    ++ developmentPackages
    ++ qmkPackages
    ++ neovimPackages;
}
