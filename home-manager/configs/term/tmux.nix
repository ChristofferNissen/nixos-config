{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;

    escapeTime = 10;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    sensibleOnTop = false;
    terminal = "screen-256color";
    shell = "${pkgs.zsh}/bin/zsh";

    extraConfig = ''
      # Rename window with prefix + r
      bind r command-prompt -I "#W" "rename-window '%%'"

      # Reload tmux config by pressing prefix + R
      bind R source-file ~/.config/tmux/tmux.conf \; display "Configuration reloaded"

      # Apply Tc
      set -ga terminal-overrides ",xterm-256color:RGB:smcup@:rmcup@"

      # Enable focus-events
      set -g focus-events on

      # Set default escape-time
      set-option -sg escape-time 10

      # kube-tmux
      # set -g status-right "#(/run/current-system/sw/bin/bash $HOME/.tmux/kube-tmux/kube.tmux 250 red cyan)"

      # tmux-sessionizer <https://github.com/edr3x/tmux-sessionizer>
      bind-key -r f run-shell "tmux neww ~/.local/scripts/tmux-sessionizer"
    '';
  };

  home.file = {
    ".tmux/kube-tmux" = {
      source =
        builtins.fetchGit { url = "https://github.com/jonmosco/kube-tmux"; };
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

  catppuccin.tmux = {
    enable = true;
    extraConfig = ''
      set -g @catppuccin_flavor "macchiato"
      set -g @catppuccin_status_background "none"

      set -g @catppuccin_window_current_number_color "#{@thm_peach}"
      set -g @catppuccin_window_current_text " #W"
      set -g @catppuccin_window_current_text_color "#{@thm_bg}"
      set -g @catppuccin_window_number_color "#{@thm_blue}"
      set -g @catppuccin_window_text " #W"
      set -g @catppuccin_window_text_color "#{@thm_surface_0}"
      set -g @catppuccin_status_left_separator "█"

      set -g status-right "#(/run/current-system/sw/bin/bash $HOME/.tmux/kube-tmux/kube.tmux 250 red cyan) #{E:@catppuccin_status_host}#{E:@catppuccin_status_date_time}"
      set -g status-right-length 200
      set -g status-left ""
    '';
  };
}
