_: {
  programs.nixvim.plugins = {
    navic = {
      enable = true;
      lsp = {
        autoAttach = true;
      };
    };
    lualine = {
      winbar = {
        lualine_a = [ "navic" ];
      };
    };
  };
}
