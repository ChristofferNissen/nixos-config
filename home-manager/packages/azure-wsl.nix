{ pkgs
, config
, ...
}:
let
  # Create a fixed Zscaler certificate with trust anchors
  fixedZscalerCert = pkgs.runCommand "zscaler-fixed.pem" { } ''
    ${pkgs.openssl}/bin/openssl x509 -in ${/etc/ssl/certs/Zscallerroot.pem} \
      -addtrust serverAuth -addtrust clientAuth \
      -setalias "Zscaler Root CA" -out $out
  '';

  customCaBundle = pkgs.runCommand "custom-ca-bundle" { } ''
    cat ${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt > $out
    cat ${fixedZscalerCert} >> $out 
  '';

  # Script to download and setup artifacttool (bypasses Python SSL issues with curl)
  setupArtifacttool = pkgs.writeShellScriptBin "setup-artifacttool" ''
    #!/usr/bin/env bash
    set -e

    ARTIFACTTOOL_DIR="$HOME/.azure/azuredevops/cli/tools/artifacttool/ArtifactTool_linux-x64_0.2.518"
    WRAPPER_PATH="${artifacttoolWrapper}/bin/artifacttool-wrapper"

    echo "Setting up artifacttool for Azure CLI..."

    # Check if already set up
    if [ -f "$ARTIFACTTOOL_DIR/artifacttool-binary" ] && [ -f "$ARTIFACTTOOL_DIR/artifacttool" ]; then
      echo "✓ artifacttool is already configured"
      exit 0
    fi

    # Check if artifacttool was downloaded by Azure CLI
    if [ -f "$ARTIFACTTOOL_DIR/artifacttool" ] && [ ! -f "$ARTIFACTTOOL_DIR/artifacttool-binary" ]; then
      echo "Found downloaded artifacttool, setting up wrapper..."
      cd "$ARTIFACTTOOL_DIR"
      mv artifacttool artifacttool-binary
      cp "$WRAPPER_PATH" artifacttool
      chmod +x artifacttool
      echo "✓ Setup complete!"
      exit 0
    fi

    # Need to download it
    echo "Downloading artifacttool with curl..."
    echo "Note: This requires running 'az artifacts' once to get a fresh download URL"
    echo "Please run any 'az artifacts' command, let it fail, then check the logs:"
    echo "  grep 'Downloading ArtifactTool from' ~/.azure/commands/*.log | tail -1"
    echo ""
    echo "Then run this script again with the URL as an argument:"
    echo "  setup-artifacttool <download-url>"

    if [ -n "$1" ]; then
      mkdir -p "$ARTIFACTTOOL_DIR"
      cd "$ARTIFACTTOOL_DIR"
      
      echo "Downloading from provided URL..."
      ${pkgs.curl}/bin/curl -L -o artifacttool.zip "$1"
      
      echo "Extracting..."
      ${pkgs.unzip}/bin/unzip -o artifacttool.zip
      rm artifacttool.zip
      
      echo "Setting up NixOS wrapper..."
      chmod +x artifacttool
      mv artifacttool artifacttool-binary
      cp "$WRAPPER_PATH" artifacttool
      chmod +x artifacttool
      
      echo ""
      echo "✓ Setup complete! Try your az artifacts command now."
    fi
  '';

  # pip-system-certs Python package
  pip-system-certs = pkgs.python3Packages.buildPythonPackage rec {
    pname = "pip-system-certs";
    version = "4.0";
    src = pkgs.fetchPypi {
      inherit pname version;
      sha256 = "sha256-mF8fQ/8Yw4ov4cszImKRzfZL7M7YVqvAzXdflJ/kZ0k=";
    };
    propagatedBuildInputs = with pkgs.python3Packages; [ wrapt ];
    doCheck = false;
  };

  # Override Azure CLI to include pip-system-certs
  azureCliWithSystemCerts = pkgs.azure-cli.overridePythonAttrs (oldAttrs: {
    propagatedBuildInputs = (oldAttrs.propagatedBuildInputs or [ ]) ++ [ pip-system-certs ];
  });

  # Create a wrapper script for artifacttool that fixes library paths for NixOS
  artifacttoolWrapper = pkgs.writeShellScriptBin "artifacttool-wrapper" ''
    #!/bin/sh
    # This wrapper fixes library paths for the artifacttool binary on NixOS
    # Based on: https://github.com/NixOS/nixpkgs/issues/383961#issuecomment-2664080733

    SCRIPT_DIR="$(dirname "$0")"
    ARTIFACTTOOL_BINARY="$SCRIPT_DIR/artifacttool-binary"

    if [ ! -f "$ARTIFACTTOOL_BINARY" ]; then
      echo "Error: artifacttool binary not found at $ARTIFACTTOOL_BINARY" >&2
      echo "The artifacttool needs to be renamed to artifacttool-binary" >&2
      exit 1
    fi

    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 \
    LD_LIBRARY_PATH=$(nix path-info --extra-experimental-features nix-command --extra-experimental-features flakes nixpkgs#stdenv.cc.cc.lib)/lib:$LD_LIBRARY_PATH \
    "$ARTIFACTTOOL_BINARY" "$@"
  '';

  # Wrapper that sets environment variables for Azure CLI
  azWrapper = pkgs.writeShellScriptBin "az" ''
    export REQUESTS_CA_BUNDLE="${customCaBundle}"
    export CURL_CA_BUNDLE="${customCaBundle}"
    export SSL_CERT_FILE="${customCaBundle}"

    # Execute the real azure-cli
    exec ${
      (azureCliWithSystemCerts.withExtensions [
        pkgs.azure-cli.extensions.azure-devops
      ])
    }/bin/az "$@"
  '';
in
{
  home.packages = with pkgs; [
    azWrapper
    artifacttoolWrapper
    setupArtifacttool
    kubelogin
  ];

  # Add helpful message on activation
  home.activation.artifacttoolInfo = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -f "$HOME/.azure/azuredevops/cli/tools/artifacttool/ArtifactTool_linux-x64_0.2.518/artifacttool-binary" ]; then
      $DRY_RUN_CMD echo ""
      $DRY_RUN_CMD echo "ℹ️  Azure artifacts requires one-time setup:"
      $DRY_RUN_CMD echo "   Run: setup-artifacttool"
      $DRY_RUN_CMD echo "   (Only needed if you use 'az artifacts' commands)"
    fi
  '';

  home.sessionVariables = {
    REQUESTS_CA_BUNDLE = "${customCaBundle}";
    CURL_CA_BUNDLE = "${customCaBundle}";
    SSL_CERT_FILE = "${customCaBundle}";
  };
}
