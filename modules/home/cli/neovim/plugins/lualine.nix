_: {
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      iconsEnabled = true;
      extensions = [ "nvim-tree" ];
    };
  };
}
