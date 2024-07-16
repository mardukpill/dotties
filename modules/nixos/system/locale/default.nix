{
	pkgs,
	namespace,
	config,
	lib,
	...
}: let
	cfg = config.${namespace}.system.locale;
	inherit (lib) mkIf mkOption;
in {
	options.${namespace}.system.locale = {
		managed = mkOption {
			type = lib.types.bool;
			default = true;
			description = "whether to manage locale.";
		};
	};

	config = mkIf cfg.managed {
		i18n.defaultLocale = "en_US.UTF-8";
		i18n.extraLocaleSettings = {
			LC_ADDRESS = "en_US.UTF-8";
			LC_IDENTIFICATION = "en_US.UTF-8";
			LC_MEASUREMENT = "en_US.UTF-8";
			LC_MONETARY = "en_US.UTF-8";
			LC_NAME = "en_US.UTF-8";
			LC_NUMERIC = "en_US.UTF-8";
			LC_PAPER = "en_US.UTF-8";
			LC_TELEPHONE = "en_US.UTF-8";
			LC_TIME = "en_US.UTF-8";
		};
	};
}
