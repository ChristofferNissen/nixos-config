{ inputs, pkgs, ... }:

{
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
    '';
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

      set -g status-right "#{E:@catppuccin_status_host}#{E:@catppuccin_status_date_time}"
      set -g status-left ""
    '';
  };

}
