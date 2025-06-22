# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [ /etc/nixos/hardware-configuration.nix ];

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Nix-LD
  programs.nix-ld.enable = true;

  # Containerization engine
  virtualisation.docker.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  networking.extraHosts = ''
    127.0.0.1 grafana.local
  '';

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # Fonts!
  fonts.packages = with pkgs;
    [
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      noto-fonts-extra
      fira-code
      fira-mono
      fira-code-symbols
    ] ++ builtins.filter lib.attrsets.isDerivation
      (builtins.attrValues pkgs.nerd-fonts);

  # enable firmware udpate daemon
  services.fwupd.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };
  services.displayManager = {
    # defaultSession = "none+i3";
    defaultSession = "hyprland-uwsm";
  };

  # Start bluetooth
  # hardware.bluetooth.enable = true; # enables support for Bluetooth
  # hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  # hardware.bluetooth.package = pkgs.bluez; # the Bluetooth stack to use
  # # hardware.bluetooth.settings.Policy.AutoEnable = true;
  # hardware.bluetooth.settings.General.Enable = "Source,Sink,Media,Socket";
  # # services.blueman.enable = true;
  hardware.enableAllFirmware = true;

  # QMK
  hardware.keyboard.qmk.enable = true;
  services.udev.packages = [ pkgs.qmk-udev-rules ];

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Hyprland
  #security.polkit.enable = true;
  # security.pam.services.swaylock = { };
  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      zsh
    ];
    variables.EDITOR = "vim";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # https://nixos.wiki/wiki/Storage_optimization
  nix.optimise.automatic = true;
  nix.optimise.dates =
    [ "03:45" ]; # Optional; allows customizing optimisation schedule

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  system.stateVersion = "24.11";
}
