{ pkgs, unstable, ... }:

with pkgs;
let
  cloudProviderPackages = [ azure-cli kubelogin ];

  pythonPackages = [
    (unstable.python312.withPackages
      (ps: with ps; [ pip black flake8 setuptools wheel twine virtualenv ]))
  ];

  # Define terminal-related packages
  terminalPackages = [
    any-nix-shell
    neofetch
    zip
    unzip
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
    # stylua
    # nixfmt-rfc-style
    direnv
    gnumake
  ];

  qmkPackages = [ qmk ];

in {
  imports = [ ./helm.nix ];

  home.packages = [
    # inputs.ladybird.packages."x86_64-linux".default
  ]
  # Kubernetes
    ++ (with unstable; [
      k9s
      kubectl
      kind
      kubernetes-helm
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
      (with dotnetCorePackages; combinePackages [ sdk_8_0 sdk_9_0 sdk_10_0 ])
      dotnet-ef
      dotnetPackages.Nuget
      # csharp-ls
    ])
    # Gleam
    ++ (with pkgs; [ gleam erlang rebar3 ]) ++ (with pkgs; [ home-manager ])
    ++ cloudProviderPackages ++ terminalPackages ++ qmkPackages
    ++ pythonPackages;
}
