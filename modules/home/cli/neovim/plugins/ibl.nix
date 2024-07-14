{inputs, ...}:  let
	inherit (inputs) nixvim;
in {
  programs.nixvim = {
    plugins.indent-blankline = {
      enable = true;
      settings.indent.highlight = [
        "RainbowRed"
        "RainbowYellow"
        "RainbowBlue"
        "RainbowOrange"
        "RainbowGreen"
        "RainbowViolet"
        "RainbowCyan"
      ];
    };
    highlight = {
      RainbowRed.fg = "#E06C75";
      RainbowYellow.fg = "#E5C07B";
      RainbowBlue.fg = "#61AFEF";
      RainbowOrange.fg = "#D19A66";
      RainbowGreen.fg = "#98C379";
      RainbowViolet.fg = "#C678DD";
      RainbowCyan.fg = "#56B6C2";
    };
  };
}
