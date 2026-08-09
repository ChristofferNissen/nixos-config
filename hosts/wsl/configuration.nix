{ pkgs, system, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.hostPlatform = system;

  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  security.pki.certificateFiles = [ /etc/pki/tls/certs/ca-zscaler.crt ];
  environment.variables = {
    "NIX_SSL_CERT_FILE" = "/etc/ssl/certs/ca-certificates.crt";
    "CONFIG" = "wsl";
  };
  security.sudo.extraConfig = ''Defaults env_keep += "NIX_SSL_CERT_FILE"'';

  time.timeZone = "Europe/Copenhagen";

  programs.nix-ld.enable = true;

  hardware.keyboard.qmk.enable = true;
  services.udev.packages = [ pkgs.qmk-udev-rules ];

  virtualisation.docker = {
    enable = true;
    daemon.settings = { "features" = { "containerd-snapshotter" = true; }; };
  };

  environment.systemPackages = with pkgs; [
    gitFull
    vim
    # jdk17.override
    # {
    #   cacert = pkgs.runCommand "mycacert" { } ''
    #     mkdir -p $out/etc/ssl/certs
    #     cat ${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt \
    #       ${
    #         /etc/pki/tls/certs/ca-zscaler.crt
    #       } > $out/etc/ssl/certs/ca-bundle.crt
    #   '';
    # }
  ];

  programs.firefox.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # https://nixos.wiki/wiki/Storage_optimization
  nix.settings.auto-optimise-store = true;
}
