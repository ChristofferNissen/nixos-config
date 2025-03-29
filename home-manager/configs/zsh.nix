{ config, pkgs, ... }:

{
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs = {
    command-not-found.enable = true;
  };
  home.packages = with pkgs; [
    zsh-powerlevel10k
    meslo-lgs-nf
    kubectx
  ];

  programs.zsh.initExtra = ''
    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    source ~/.p10k.zsh
    export PATH=$HOME/go/bin:$PATH
    # export YSU_MESSAGE_POSITION="after"
  '';
  home.file = {
    ".p10k.zsh" = {
      source = ./zsh/p10k.zsh;
      executable = true;
    };
  };

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
    plugins = [
        {
          # will source you-should-use.plugin.zsh
          name = "you-should-use";
          src = pkgs.fetchFromGitHub {
            owner = "MichaelAquilina";
            repo = "zsh-you-should-use";
            rev = "1.9.0";
            sha256 = "sha256-+3iAmWXSsc4OhFZqAMTwOL7AAHBp5ZtGGtvqCnEOYc0=";
          };
        }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
        "thefuck"
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
        "terraform"
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
