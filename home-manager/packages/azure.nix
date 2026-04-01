{ pkgs, ... }: {
  home.packages = with pkgs; [
    (azure-cli.withExtensions [ azure-cli.extensions.azure-devops ])
    kubelogin
  ];
}
