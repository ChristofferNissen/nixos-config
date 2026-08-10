{ pkgs, unstable, ... }:

with pkgs;
let
  pythonPackages = [
    (unstable.python312.withPackages (
      ps: with ps; [
        pip
        black
        flake8
        setuptools
        wheel
        twine
        virtualenv
      ]
    ))
  ];

  # Define terminal-related packages
  terminalPackages = [
    nh
    # ffmpeg
    # ffmpeg-full
    any-nix-shell
    fastfetch
    zip
    unzip
    tree
    gnupg
    aria2
    imagemagick
    feh
    gotop
    dtop
    htop
    btop
    zsh
    oh-my-zsh
    fzf
    pay-respects
    yq
    jq
    tmux
    gcc
    tt
    lazydocker
    tldr
    bat
    hwatch
    viddy
    xdg-utils
    ncdu
    dig
    openssl
    tmate
    direnv
    gnumake
    lf
    yazi
    # github-copilot-cli
    # nh
    # starship
    eza
    zoxide
    atuin
    delta
  ];

  qmkPackages = [ qmk ];

  neovimPackages = (
    with unstable;
    [
      tree-sitter
      ripgrep
      fd
      wget
      luarocks
      biome
      tectonic
      texliveSmall
      # mermaid-cli
      ghostscript
      python312Packages.pylatexenc
      nixd
      nodejs_22
      php84Packages.composer
      jdk21
      kotlin
      gradle
      php
      luajit
      julia-bin
      mercurial
    ]
  );

in
{
  home.packages = [
    yarn
    powershell
  ]
  # Kubernetes
  ++ (with unstable; [
    k9s
    flux9s
    kubectl
    talosctl
    kind
    kubernetes-helm
    kustomize
    oras
    skopeo
    argocd
    fluxcd
    cilium-cli
    crossplane-cli
    kubespy
    kubectl-tree
    stern
    dive
    krew
    age
  ])
  # Development
  ++ (with unstable; [
    (lib.lowPrio vim)
    go
    gotools
    gofumpt
    ko
    golangci-lint
    delve
    mockgen
    zig
    # rustup
    #jetbrains.goland
    go-task
    lazygit
    sapling
    mdbook
    tenv
    bruno
  ])
  ++ neovimPackages
  # Gleam
  ++ (with pkgs; [
    gleam
    beamPackages.erlang
    rebar3
  ])
  ++ (with pkgs; [ home-manager ])
  ++ terminalPackages
  ++ qmkPackages
  ++ pythonPackages;
}
