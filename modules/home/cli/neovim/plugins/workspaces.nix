{ pkgs, ... }:
let # /
  workspaces = pkgs.vimUtils.buildVimPlugin {
    name = "workspaces-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "natecraddock";
      repo = "workspaces.nvim";
      rev = "447306604259619618cd84c15b68f2ffdbc702ae";
      hash = "sha256-YIu6Wtzb79itoilv6g/AJyqORJz14UYwTPq9kW0D8ck=";
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = [ workspaces ];

    extraConfigLua = # lua
      ''
        require("workspaces").setup()
      '';
  };
}
