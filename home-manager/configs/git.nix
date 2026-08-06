{
  programs.git = {
    enable = true;
    signing = {
        format = null;
    };
    settings = {
      user =
        {
          name = "Christoffer Nissen";
          email = "christoffer.nissen@gmail.com";
        };
      init = {
        defaultBranch = "main";
      };
      push = { autoSetupRemote = true; };
      core = { editor = "nvim"; };
    };
  };
}
