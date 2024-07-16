{
	lib,
	namespace,
	config,
	...
}: let 
	inherit (lib) mkIf mkOption;

	cfg = config.${namespace}.system.time;
in {
	option.${namespace}.system.time = {
		managed = mkOption {
			type = lib.types.bool;
			default = true;
			description = "whether to manage timezone";
		};
	};

	config = mkIf cfg.managed {
		time.timeZone = "America/New_York";
	};
}
