{
	pkgs,
	lib,
	config,
	namespace,
	...
}: let
	inherit (lib) mkIf mkEnableOption;
	cfg = config.${namespace}.cli.tools;
in {
	options.${namespace}.cli.tools = {
		enable = mkEnableOption "cli tools bundle.";
	};

	config = mkIf cfg.enable {
		programs.zoxide = mkIf config.${namespace}.cli.fish.enable {
			enable = true;
			enableFishIntegration = true;
		};

		home.packages = with pkgs; [
			p7zip
			tree
			fd
			tig
			htop
			curl
			wget
			unzip
		];
	};
}
