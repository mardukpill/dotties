{
	pkgs,
	namespace,
	lib,
	config,
	...
}: let
	inherit (lib) mkIf mkOpt;

	cfg = config.${namespace}.system.git;
in {
	option.${namespace}.system.git = {
		enable = mkOpt lib.types.bool true "whether to manage git configuration";
	};
	
	config = mkIf cfg.enable {
		environment.systemPackages = with pkgs; [
			git
		];
	};
}
