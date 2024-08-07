_: {
  programs.nixvim.plugins = {
    which-key = {
      enable = true;
      showKeys = true;
      keyLabels = {
        "<space>" = "SPC";
        "<leader>" = "SPC";
        "<cr>" = "ENTER";
        "<CR>" = "ENTER";
        "<tab>" = "TAB";
        "<TAB>" = "TAB";
        "<bs>" = "BACKSPACE";
        "<BS>" = "BACKSPACE";
      };
    };
  };
}
