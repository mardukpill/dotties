_: {
  programs.nixvim.plugins = {
    navic = {
      enable = true;
      settings = {
        lsp = {
          autoAttach = true;
        };
      };
    };
    lualine = {
      settings.winbar = {
        lualine_a = [ "navic" ];
      };
    };
  };
}
