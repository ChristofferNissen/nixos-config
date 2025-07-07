{ pkgs, ... }: {
  home.packages = with pkgs; [ sqlite ];
  home.sessionVariables = {
    LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.so";
  };
}
