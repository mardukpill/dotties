{
	pkgs,
	inputs,
	config,
	namespace,
	lib,
	...
}: let 
	inherit (lib) mkIf mkEnableOption;

	cfg = config.${namespace}.system.fonts;
in {
	options.${namespace}.system.fonts = {
		enable = mkEnableOption "manage fonts.";
	};

	config = mkIf cfg.enable {
		environment.systemPackages = with pkgs; [
			jetbrains-mono
			nerdfonts

			material-icons
			material-design-icons
			vimPlugins.nvim-web-devicons

			corefonts
			vistafonts

			noto-fonts
			noto-fonts-extra

			noto-fonts-emoji
			noto-fonts-color-emoji
			twemoji-color-font

			font-awesome
			roboto-mono
			montserrat
		];

		fonts.fontconfig.enable = true;
	};
}
