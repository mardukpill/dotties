{inputs, ...}: let
	inherit (inputs) nixvim;
in {
	programs.nixvim = {
		plugins.noice.enable = true;
	};
}
