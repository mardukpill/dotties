{
  programs.waybar.settings.mainBar = {
    # TODO: ideally this should not be specific to "mainBar"
    network = {
      # interface = "wlo1";
      format = "{ipaddr}";
      format-wifi = "{ipaddr} ({signalStrength}%)  ";
      format-ethernet = "{ipaddr} 󰈀";
      format-disconnected = ""; # An empty format will hide the module
      tooltip-format = "{ifname} via {gwaddr} 󰊗";
      tooltip-format-wifi = "{essid} ({signalStrength}%)   ";
      tooltip-format-ethernet = "{ifname} ";
      tooltip-format-disconnected = "Disconnected";
      # max-length = 18;
      # on-click = "alacritty -e nmtui";
    };
  };
}
