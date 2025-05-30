# NixOS WSL Guide

## Prerequisites

```bash
# enable experimental features
mkdir -p ~/.config/nix
cat <<EOF > ~/.config/nix/nix.conf
experimental-features = flakes nix-command
EOF

# install nix package manager (assume done)

### WSL2 (`x86_64-linux`)

To list all linux distributions currently installed, run the following PowerShell:

```powershell
wsl -l -v
```

NixOS is not yet packaged as a official WSL distribution or on the Microsoft store. Download the latest release of `nixos-wsl.tar.gz` from the [NixOS-WSL Github page](https://github.com/nix-community/NixOS-WSL/releases).

Import the WSL container using PowerShell:

```powershell
wsl --import NixOS .\NixOS\ .\Downloads\nixos-wsl.tar.gz --version 2
```

Start it with PowerShell:

```powershell
wsl -d NixOS
```

> Make sure to update custom CA certificate according to your company settings.

```bash
cat <<EOF | sudo tee /etc/pki/tls/certs/ca-zscaler.crt
-----BEGIN CERTIFICATE-----
...
-----END CERTIFICATE-----
EOF

# add default CA certificates info new file
cat /etc/ssl/certs/ca-certificates.crt | sudo tee --append /etc/pki/tls/certs/ca-zscaler.crt
```

Then, change `/etc/nixos/configuration.nix` file and ensure it has this line:

```nix
  security.pki.certificateFiles = [ /etc/pki/tls/certs/ca-zscaler.crt ];
  environment.variables = {
    "NIX_SSL_CERT_FILE" = "/etc/pki/tls/certs/ca-zscaler.crt";
  };
  security.sudo.extraConfig = ''
    Defaults env_keep += "NIX_SSL_CERT_FILE"
  '';
```

Run

```bash
sudo -E NIX_SSL_CERT_FILE=/etc/pki/tls/certs/ca-zscaler.crt nixos-rebuild switch
```

command. It will produce some warnings in the begining, but if the certificate is correct, it will complete the rebuild.

```bash
sudo nix-channel --update
```

After the above is done, and corporate proxy is well configured, proceed to the following:

```bash
sudo nixos-rebuild switch --flake github:christoffernissen/nixos-config#wsl --impure
```
