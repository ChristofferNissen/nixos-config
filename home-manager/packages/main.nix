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
    argocd
    cilium-cli
    crossplane-cli
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
    playerctl
    ripgrep
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
  ];

  # Define development-related packages
  developmentPackages = [
    vim
    go
    gotools
    gofumpt
    ko
    golangci-lint
    mockgen
    zig
    rustup
    #jetbrains.goland
    go-task
    lazygit
    mdbook
    tenv
    bruno
  ];

  qmkPackages = [
    qmk
    qmk_hid
  ];

  neovimPackages = [
    marksman
    markdownlint-cli2
    # neovim
    # (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

in
{
  home.packages =
    [ inputs.ghostty.packages."x86_64-linux".default ]
    ++ (with unstable; [
      gleam
      erlang
      rebar3
    ])
    ++ (with pkgs; [
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
