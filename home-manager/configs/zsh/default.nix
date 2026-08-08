{ config, pkgs, ... }:

{
  programs = {
    command-not-found.enable = true;
  };

  # Move later
  home.sessionPath = [
    "$HOME/go/bin"
  ];
  
  home.file = {
    ".p10k.zsh" = {
      source = ./dotfiles/p10k.zsh;
      executable = true;
    };
  };

  home.packages = with pkgs; [
    zsh-powerlevel10k
    meslo-lgs-nf
    kubectx
  ];

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
    KUBE_EDITOR = "vim";
    GOBIN = "$HOME/go/bin";
  };

  programs.zsh.initContent = ''
    eval "$(pay-respects zsh --alias)"
    bindkey -s ^f "tmux-sessionizer\n"

    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    source ~/.p10k.zsh
  '';

  programs.zsh.profileExtra = ''
    . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
  '';

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
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

  programs.delta.enable = true;
  programs.delta.options = {
    navigate = true;
    line-numbers = true;
    # side-by-side = true;
  };
  programs.delta.enableGitIntegration = true;

  # programs.starship = {
  #   enable = true;
  #   enableZshIntegration = true;
  #   settings = {
  #     add_newline = false;
  #     line_break.disabled = true;
  #   };
  # };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # To import from zsh history above, use
  # HISTFILE="/home/cn/.local/share/zsh/history" atuin import zsh
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = [ "--disable-up-arrow" ];
    # settings = {
    #     search_mode = "skim";
    #     style = "compact";
    # };
  };
}
