{
  programs.waybar.settings.mainBar = {
    # TODO: ideally this should not be specific to "mainBar"
    "hyprland/window" = {
      format = "{class}";
      separate-outputs = true;
      rewrite = {
        "" = "  ";
				"org.keepassxc.KeePassXC" = " 󰟵";
				"firefox" = "󰈹 firefox";
      };
    };
  };
}
