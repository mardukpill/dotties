{
	lib,
	namespace,
	config,
	...
}: let 
	inherit (lib) mkOption mkIf;

	cfg = config.${namespace}.hw.audio;
in {
	option.${namespace}.hw.audio = {
		provider = mkOption {
			type = lib.types.enum [ "pipewire" ];
			default = "pipewire";
			description = "which audio provider to use.";
		};
	};
	
	config = mkIf (cfg.provider != "") {
		imports = mkIf (cfg.provider == "pipewire") [ ./pipewire.nix ];
	};
}
