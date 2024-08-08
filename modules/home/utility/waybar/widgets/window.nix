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
  };
}
