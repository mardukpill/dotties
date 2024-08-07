_: {
  programs.nixvim.plugins.lualine = {
    enable = true;
    iconsEnabled = true;
    extensions = [ "nvim-tree" ];
  };
}
