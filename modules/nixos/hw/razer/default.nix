{
	lib,
	namespace,
	config,
	...
}: let
	inherit (lib) mkIf mkEnabledOption;

	cfg = config.${namespace}.hw.razer;
in {
	option.${namespace}.hw.razer = {
		enable = mkEnabledOption "razer blade tools."	;
	};
	
	config = mkIf cfg.enable {
		services = {
			razer-laptop-control.enable = true;
			udev.extraRules = '' 
				KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="plugdev"
			''; # needed for correct permissions for razer-laptop-control
		};
	};
}
