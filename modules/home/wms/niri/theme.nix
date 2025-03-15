{
  config,
  ...
}:
let
  palette = config.colorScheme.palette;
in
{
  window-rules = [
    {
      draw-border-with-background = false;
    }
    {
      geometry-corner-radius =
        let
          r = 4.0;
        in
        {
          top-left = r;
          top-right = r;
          bottom-left = r;
          bottom-right = r;
        };
      clip-to-geometry = true;
    }
    {
      matches = [
        {
          app-id = "firefox";
          title = "^Picture-in-Picture$";
        }
      ];
      open-floating = true;
    }
    {
      matches = [
        { app-id = "^org\.keepassxc\.KeePassXC$ "; }
      ];
      block-out-from = "screencast";
    }
  ];

  layout = {
    gaps = 5;
    border = {
      width = 5;
      active.color = "#${palette.base04}FF";
      inactive.color = "#${palette.base07}FF";

    };
    always-center-single-column = true;
    tab-indicator = {
      active.color = "#${palette.base04}FF";
      inactive.color = "#${palette.base07}FF";
    };
  };
}
