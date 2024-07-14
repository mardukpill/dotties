{
	pkgs,
	lib,
	config,
	namespace,
	...
}: let
	inherit (lib) mkEnableOption mkIf;
	cfg = config.${namespace}.apps.alacritty;
in {
	options.${namespace}.apps.alacritty = {
		enable = mkEnableOption "alacritty.";
	};

	config = cfg.enable {
		programs.alacritty = {
			enable = true;
			settings = {
				live_config_reload = true;

				window.decorations = "none";
				window.dynamic_title = true;
				window.padding.x = 0;
				window.padding.y = 0;
				window.opacity = 0.8;

				cursor.style.blinking = "On";
				cursor.style.shape = "Block";

				colors = {
					primary = {
						background = "#1E2128";
						foreground = "#ABB2BF";
					};

					normal = {
						black = "#32363D";
						blue = "#62AEEF";
						cyan = "#55B6C2";
						green = "#98C379";
						magenta = "#C778DD";
						red = "#E06B74";
						white = "#ABB2BF";
						yellow = "#E5C07A";
					};

					bright = {
						black = "#50545B";
						blue = "#6CB8F9";
						cyan = "#5FC0CC";
						green = "#A2CD83";
						magenta = "#D282E7";
						red = "#EA757E";
						white = "#B5BCC9";
						yellow = "#EFCA84";
					};
				};

				font = {
					size = 14;

					normal.family = "JetBrainsMono Nerd Font";
					italic.family = "JetBrainsMono Nerd Font";

					bold.family = "JetBrainsMono Nerd Font";
					bold_italic.family = "JetBrainsMono Nerd Font";
				};
			};
		};
	};
}
