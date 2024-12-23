{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Christoffer Nissen";
    userEmail = "christoffer.nissen" + "@" + "gmail.com";
  };
}
