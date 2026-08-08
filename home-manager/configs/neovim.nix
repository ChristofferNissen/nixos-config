{ unstable, ... }:

let
  repo = fetchGit {
    url = "https://github.com/ChristofferNissen/nvim-config";
    ref = "main";
    rev = "c31569db63a903cb77ca12c04b802a1de80edf1b";
  };
in
{
  programs.neovim = {
    package = unstable.neovim-unwrapped;
    enable = true;
    vimAlias = true;
    extraLuaPackages = ps: [
      ps.jsregexp
      ps.tiktoken_core
      ps.luasql-sqlite3
    ];
    withRuby = false;
    withPython3 = false;
  };

  home.file = {
    "./.config/nvim/" = {
      source = repo;
      recursive = true;
    };
  };

  # home.sessionPath = [
  #  "$HOME/.local/share/\${NVIM_APPNAME:-nvim}/mason/bin/"
  # ];
}
