{ pkgs, ... }:
{
  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    pulse = {
      enable = true;
    };
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  environment.systemPackages = with pkgs; [
    pwvucontrol
    pulsemixer
    helvum
  ];
}
