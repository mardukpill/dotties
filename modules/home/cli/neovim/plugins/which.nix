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
      /*
        settings.spec = [
          {
            __unkeyed = "<leader>b";
            group = " Tree";
          }
          {
            __unkeyed = "<leader>g";
            group = "󰊢 Git";
          }
          {
            __unkeyed = "<leader>s";
            group = " Search";
          }
          {
            __unkeyed = "<leader>r";
            group = " Rename";
          }
          {
            __unkeyed = "<leader>t";
            group = " Terminal";
          }
          {
            __unkeyed = "<leader>w";
            group = "Workspaces";
          }
        ];
      */
    };
  };
}
