{
  pkgs,
  unstable,
  system,
  inputs,
  ...
}:

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
    containerd
    nerdctl
    kaniko
  ];

  cloudPackages = [
    azure-cli
    kubelogin
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
    pamixer
    nixfmt-rfc-style
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
    tmux
    gcc
    yamlfmt
    yamllint
    tt
  ];

  # Define development-related packages
  developmentPackages = [
    vim
    go
    golangci-lint
    zig
    rustup
    
    #jetbrains.goland
    go-task
    lazygit
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
    (with unstable; [
      gleam
      erlang
    ]) ++ (with pkgs; [
      home-manager
    ])
    ++ defaultKubernetes
    ++ cloudPackages
    ++ miscPackages
    ++ terminalPackages
    ++ developmentPackages
    ++ qmkPackages
    ++ neovimPackages;
   
}
