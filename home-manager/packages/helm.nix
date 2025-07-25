{ pkgs, ... }:
let
  my-kubernetes-helm = with pkgs;
    wrapHelm kubernetes-helm {
      plugins = with pkgs.kubernetes-helmPlugins; [
        helm-secrets
        helm-diff
        helm-unittest
      ];
    };
in
{
  home.packages = [
    my-kubernetes-helm
    # (pkgs.wrapHelm pkgs.kubernetes-helm { plugins = [
    # pkgs.kubernetes-helmPlugins.helm-diff
    # pkgs.kubernetes-helmPlugins.helm-secrets
    # ]; })
  ];
}
