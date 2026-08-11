{ ... }: {
  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000; # 5 seconds
      background-color = "#1e1e2e";
      text-color = "#cdd6f4";
    };
  };

  # catppuccin.mako.enable = true;
}
