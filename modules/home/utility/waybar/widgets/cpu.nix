{
  programs.waybar.settings.mainBar = {
    # TODO: ideally this should not be specific to "mainBar"
    "cpu" = {
      interval = 10;
      format = "{}% ";
      max-length = 10;
    };
  };
}
