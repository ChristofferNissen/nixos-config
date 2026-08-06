{ pkgs, lib, ... }:
let
  isMac = pkgs.stdenv.isDarwin;
  isWSL =
    # config.wsl.enable;
    # pkgs.stdenv.isLinux && lib.strings.hasInfix "Microsoft" pkgs.stdenv.hostPlatform.uname.release;
    # lib.strings.hasInfix "microsoft" (builtins.readFile /proc/version);
    (builtins.getEnv "WSL_DISTRO_NAME") != "";
in
{
  imports = [
    ./dotnet.nix
    ./helm.nix
    ./main.nix
  ]
  ++ (if isWSL then [ ./azure-wsl.nix ] else [ ./azure.nix ])
  ++ (if isMac then [ ] else [ ./sqlite.nix ]);
}
