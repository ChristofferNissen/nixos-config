{ pkgs, ... }:

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
  ];

  # Define development-related packages
  developmentPackages = [
    vim
    go
    go-task
  ];

  neovimPackages = [ neovim ];

in
{
  home.packages =
    with pkgs;
    [ 
      bitwarden-desktop
      home-manager
    ]
    ++ defaultKubernetes
    ++ miscPackages
    ++ terminalPackages
    ++ developmentPackages
    ++ neovimPackages;
}
