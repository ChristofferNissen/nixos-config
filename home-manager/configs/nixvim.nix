{pkgs, inputs, ...}:
{
    home.packages = [ inputs.nixvim-config.packages.${pkgs.system}.default ];
}
