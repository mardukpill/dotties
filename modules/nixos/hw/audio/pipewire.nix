{
	lib,
	pkgs,
	...
}: let
	inherit (lib) enabled;
in {
	hardware.pulseaudio.enable = false;

	services.piepwire = {
		enable = true;
		pulse = enabled;
		alsa = {
			enable = true;
			support32Bit = true;
		};
	};
	
	environment.systemPackages = with pkgs; [
		pavucontrol
		pulsemixer
		helvum
	];
}
