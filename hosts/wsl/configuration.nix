{ pkgs, system, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.hostPlatform = system;

  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Zscaler
  security.pki.certificateFiles = [ /etc/pki/tls/certs/ca-zscaler.crt ];
  environment.variables = {
    "NIX_SSL_CERT_FILE" = "/etc/ssl/certs/ca-certificates.crt";
  };
  security.sudo.extraConfig = ''Defaults env_keep += "NIX_SSL_CERT_FILE"'';

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Nix-LD
  programs.nix-ld.enable = true;

  # QMK
  hardware.keyboard.qmk.enable = true;
  services.udev.packages = [ pkgs.qmk-udev-rules ];

  # Docker
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      "features" = { "containerd-snapshotter" = true; };
    };
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

  # Install firefox.
  programs.firefox.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # https://nixos.wiki/wiki/Storage_optimization
  nix.settings.auto-optimise-store = true;

}
