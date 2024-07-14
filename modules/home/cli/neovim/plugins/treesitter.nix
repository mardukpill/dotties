{inputs, ...}: let
	inherit (inputs) nixvim;
in {
  programs.nixvim.plugins.treesitter = {
    enable = true;
  };
}
