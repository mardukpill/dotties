{
  programs.waybar.settings.mainBar = {
    "pulseaudio" = {
      format = "{volume}% {icon}";
      format-bluetooth = "{volume}% {icon}";
      format-muted = "";
      format-icons = {
        # "alsa_output.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo-output" = "";
        "headphone" = "";
        "hands-free" = "";
        "headset" = "";
        "phone" = "";
        "phone-muted" = "";
        "portable" = "";
        "car" = "";
        "default" = ["" ""];
      };
      scroll-step = 1;
      on-click = "pavucontrol";
    };
  };
}
