{ config, ... }:
{
  programs.k9s = {
    enable = true;

    settings = {
      k9s = {
        liveViewAutoRefresh = false;
        screenDumpDir = "${config.home.homeDirectory}/.local/state/k9s/sceen-dumps";
        refreshRate = 2;
        maxConnRetry = 15;
        readOnly = false;
        noExitOnCtrlC = true;

        ui = {
          enableMouse = false;
          headless = false;
          logoless = true;
          crumbsless = false;
          reactive = false;
          noIcons = false;
          defaultToFullScreen = false;
        };

        skipLatestRevCheck = false;
        disablePodCounting = false;

        shellPod = {
          image = "busybox:1.35.0";
          namespace = "default";
          limits = {
            cpu = "100m";
            memory = "100Mi";
          };
        };

        imageScans = {
          enable = false;
          exclusions = {
            namespace = [ ];
            labels = { };
          };
        };

        logger = {
          tail = 100;
          buffer = 5000;
          sinceSeconds = -1;
          textWrap = false;
          showTime = false;
        };

        thresholds = {
          cpu = {
            critical = 90;
            warn = 70;
          };
          memory = {
            critical = 90;
            warn = 70;
          };
        };
      };
    };
  };

  xdg.configFile."k9s/plugins.yaml" = {
    source = ./dotfiles/plugins.yaml;
  };

  # catppuccin.k9s.enable = true;
}
