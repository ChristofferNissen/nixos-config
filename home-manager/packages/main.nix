{
  pkgs,
  unstable,
  ...
}:

with pkgs;
let
  cloudProviderPackages = [
    azure-cli
    kubelogin
  ];

  # Define the default Python packages
  # defaultPython = python3.withPackages (
  #   python-packages: with python-packages; [
  #     black
  #     flake8
  #     setuptools
  #     wheel
  #     twine
  #     virtualenv
  #   ]
  # );

  # Define miscellaneous packages
  miscPackages = [
    appimage-run
    appimagekit
    arandr
    autorandr
    tmate
    # bluez
    brightnessctl
    pamixer
    nixfmt-rfc-style
    playerctl
    stylua
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
    btop
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
    lazydocker
    tldr
    bat
    hwatch
    viddy
    xdg-utils
  ];

  qmkPackages = [
    qmk
    qmk_hid
  ];

in
{
  imports = [
    ./helm.nix
  ];

  home.packages =
    [
      # inputs.ladybird.packages."x86_64-linux".default
    ]
    ++ (with unstable; [
      bitwarden-cli
    ])
    # Kubernetes
    ++ (with unstable; [
      k9s
      kubectl
      kind
      kubernetes-helm
      oras
      skopeo
      containerd
      nerdctl
      kaniko
      argocd
      fluxcd
      cilium-cli
      crossplane-cli
      kubespy
      kubectl-tree
      stern
      dive
    ])
    # Development
    ++ (with unstable; [
      vim
      go
      gotools
      gofumpt
      ko
      golangci-lint
      delve
      mockgen
      zig
      rustup
      #jetbrains.goland
      go-task
      lazygit
      sapling
      mdbook
      tenv
      bruno
      gleam
      erlang
      rebar3
    ])
    ++ (with pkgs; [
      home-manager
      vlc
    ])
    ++ cloudProviderPackages
    ++ miscPackages
    ++ terminalPackages
    ++ qmkPackages;
}
