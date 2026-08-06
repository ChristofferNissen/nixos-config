{ config, pkgs, ... }:

{
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs = { command-not-found.enable = true; };

  home.packages = with pkgs; [ zsh-powerlevel10k meslo-lgs-nf kubectx ];

  # home.file = {
  #   ".p10k.zsh" = {
  #     source = ./dotfiles/p10k.zsh;
  #     executable = true;
  #   };
  # };

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
    KUBE_EDITOR = "vim";
  };

  programs.zsh.initContent = ''
    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/config/p10k-pure.zsh
    # source ~/.p10k.zsh
    eval "$(pay-respects zsh --alias)"

    export GOBIN=$HOME/go/bin
    export MASONBIN="$HOME/.local/share/''${NVIM_APPNAME:-nvim}/mason/bin/:$PATH"
    export PATH=$GOBIN:$PATH
    export PATH=$MASONBIN:$PATH
    export PATH=$HOME/.dotnet/tools:$PATH
    export PATH=$HOME/.local/scripts/:$PATH

    # export YSU_MESSAGE_POSITION="after"

    bindkey -s ^f "tmux-sessionizer\n"
  '';

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
      k = "kubectl";
      kx = "kubectx";
      kn = "kubens";
      kxc = "kubectx -c";
      knc = "kubens -c";
      ggraph = "git log --decorate --graph --oneline --all";
      cd = "z";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    plugins = [{
      # will source you-should-use.plugin.zsh
      name = "you-should-use";
      src = pkgs.fetchFromGitHub {
        owner = "MichaelAquilina";
        repo = "zsh-you-should-use";
        rev = "1.9.0";
        sha256 = "sha256-+3iAmWXSsc4OhFZqAMTwOL7AAHBp5ZtGGtvqCnEOYc0=";
      };
    }];
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
        "direnv"
        "tmux"
        "kubectl"
        "kubectx"
        "argocd"
        "azure"
        "helm"
        "kind"
        "golang"
        "tmux"
        "tldr"
        "kube-ps1"
        "zoxide"
      ];
      # theme = "robbyrussell";
    };
    localVariables = {
      ZSH_TMUX_AUTOSTART = "false";
      ZSH_TMUX_AUTOSTART_ONCE = "true";
    };
  };
}
