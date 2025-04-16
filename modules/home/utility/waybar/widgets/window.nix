{
  programs.waybar.settings.mainBar = {
    "hyprland/window" = {
      format = "{class}";
      separate-outputs = true;
      rewrite = {
        "" = "  ";
        "org.keepassxc.KeePassXC" = " 󰟵 ";
        "firefox" = "󰈹 firefox";
        "neovide" = " nvimized";
        # FIXME: spotify resets its class.
      };
    };
    "niri/window" = {
      format = "{app_id}";
      separate-outputs = true;
      icon = true;
      rewrite = {
        " " = "  ";
      };
    };
  };
}
