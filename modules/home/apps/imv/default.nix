{
	lib,
	pkgs,
	inputs,
	namespace,
	config,
	...
}: let
	inherit (lib) mkIf mkOption mkEnableOption enabled;

	cfg = config.${namespace}.apps.imv;
in {
	options.${namespace}.apps.imv= {
		enable = mkEnableOption "imv.";
	};

	config = mkIf cfg.enable {
		programs.imv = {
			enable = true;
		};

		xdg.mimeApps = lib.mkIf pkgs.stdenv.isLinux {
			associations.added = {
				"image/*" = ["imv.desktop"];
			};
			defaultApplications = {
				"image/*" = ["imv.desktop"];
			};
		};
	};
}
