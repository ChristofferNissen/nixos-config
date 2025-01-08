{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Christoffer Nissen";
    userEmail = "christoffer.nissen" + "@" + "gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
    };
  };
}
