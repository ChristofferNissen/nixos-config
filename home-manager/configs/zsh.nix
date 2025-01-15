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
  ];

  programs.zsh.initExtra = ''
    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    source ~/.p10k.zsh
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
      cat = "bat";
      ggraph = "git log --decorate --graph --oneline --all";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
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
      ];
      theme = "robbyrussell";
    };
    localVariables = {
      ZSH_TMUX_AUTOSTART = "false";
      ZSH_TMUX_AUTOSTART_ONCE = "true";
    };
  };
}
