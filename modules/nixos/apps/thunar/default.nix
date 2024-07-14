{
	pkgs,
	lib,
	config,
	namespace,
	...
}: let
	inherit (lib) mkEnableOption mkIf;

	cfg = config.${namespace}.apps.thunar;

in {
	options.${namespace}.apps.thunar = {
		enable = mkEnableOption "thunar.";
	};
	
	config = mkIf cfg.enable {
		programs.thunar = {
			enable = true;
			plugins = with pkgs.xfce; [
				thunar-archive-plugin
				thunar-volman
			];
		};

		environment.systemPackages = with pkgs; [
			ark
		];
	};
}
