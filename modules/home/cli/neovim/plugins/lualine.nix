{inputs, ...}: let
	inherit (inputs) nixvim;
in {
  programs.nixvim.plugins.lualine = {
    enable = true;
    iconsEnabled = true;
    extensions = ["nvim-tree"];
  };
}
