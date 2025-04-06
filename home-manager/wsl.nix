{
  config,
  pkgs,
  userName,
  ...
}:

{
  programs.git.userEmail = "cnis" + "@" + "bankingcircle.com";

  imports = [
    ./common.nix
    ./packages/main.nix
    ./configs/main.nix
  ];

  # SYSTEMD
  systemd.user = {
    services = {
      "az-aks-get-credentials-neu" = {
        Service = {
          Type = "oneshot";
          ExecStart = "/etc/profiles/per-user/${userName}/bin/az aks get-credentials -n neu-aks-shared-disp --resource-group neu-aks-shared-dev-rg --file /home/${userName}/.kube/config --overwrite --only-show-errors";
        };
      };
      "az-aks-get-credentials-weu" = {
        Service = {
          Type = "oneshot";
          ExecStart = "/etc/profiles/per-user/${userName}/bin/az aks get-credentials -n weu-aks-shared-disp --resource-group weu-aks-shared-dev-rg --file /home/${userName}/.kube/config --overwrite --only-show-errors";
        };
      };
    };
  };
  systemd.user.timers = {
    "az-aks-get-credentials-neu" = {
      Timer = {
        OnCalendar = "Mon 06:00";
        Persistent = true;
        Unit = "az-aks-get-credentials-neu.service";
      };
      Install = {
        WantedBy = [ "timers.target" ];
      };
    };
    "az-aks-get-credentials-weu" = {
      Timer = {
        OnCalendar = "Mon 06:00";
        Persistent = true;
        Unit = "az-aks-get-credentials-weu.service";
      };
      Install = {
        WantedBy = [ "timers.target" ];
      };
    };
  };
}
