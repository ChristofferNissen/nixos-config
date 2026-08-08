{ pkgs, ... }:
{
  # home.sessionVariables = {
  #   ZSH_TMUX_AUTOSTART = "false";
  #   ZSH_TMUX_AUTOSTART_ONCE = "true";
  # };

  programs.tmux = {
    enable = true;
    baseIndex = 1;

    escapeTime = 10;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    # sensibleOnTop = false;
    terminal = "screen-256color";
    shell = "${pkgs.zsh}/bin/zsh";

    focusEvents = false;

    plugins = [
      pkgs.tmuxPlugins.sensible
    ];

    extraConfig = ''
      # Rename window with prefix + r
      bind r command-prompt -I "#W" "rename-window '%%'"

      # Reload tmux config by pressing prefix + R
      bind R source-file ~/.config/tmux/tmux.conf \; display "Configuration reloaded"

      # kube-tmux
      set -g status-right "#(/run/current-system/sw/bin/bash $HOME/.tmux/kube-tmux/kube.tmux 250 red cyan)"

      # tmux-sessionizer <https://github.com/edr3x/tmux-sessionizer>
      bind-key -r f run-shell "tmux neww ~/.local/scripts/tmux-sessionizer"

      # split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      set -g status-left ""

    '';
  };

  home.file = {
    ".tmux/kube-tmux" = {
      source = fetchGit { url = "https://github.com/jonmosco/kube-tmux"; };
      recursive = true;
    };
    ".local/scripts/tmux-sessionizer" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        if [[ $# -eq 1 ]]; then
            selected=$1
        else
            # selected=$(find ~/projects ~/tests -mindepth 1 -maxdepth 1 -type d | fzf)
            selected=$(find ~/code ~/Documents/ -mindepth 1 -maxdepth 1 -type d | fzf)
        fi

        if [[ -z $selected ]]; then
            exit 0
        fi

        selected_name=$(basename "$selected" | tr . _)
        tmux_running=$(pgrep tmux)

        if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
            tmux new-session -s $selected_name -c $selected
            exit 0
        fi

        if ! tmux has-session -t=$selected_name 2> /dev/null; then
            tmux new-session -ds $selected_name -c $selected
        fi

        if [[ -z $TMUX ]]; then
            tmux attach -t $selected_name
        else
            tmux switch-client -t $selected_name
        fi
      '';
    };
  };

  home.sessionPath = [
    "$HOME/.local/scripts/"
  ];

  catppuccin.tmux.enable = true;
  catppuccin.tmux.flavor = "macchiato";
}
