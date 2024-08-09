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
      settings = {
        /*
          replace = {
            desc = [
              [
                "<space>"
                "SPC"
              ]
              [
                "<leader>"
                "SPC"
              ]
              [
                "<cr>"
                "ENTER"
              ]
              [
                "<CR>"
                "ENTER"
              ]
              [
                "<tab>"
                "TAB"
              ]
              [
                "<TAB>"
                "TAB"
              ]
              [
                "<bs>"
                "BACKSPACE"
              ]
              [
                "<BS>"
                "BACKSPACE"
              ]
            ];
          };
        */
        spec = [
          {
            __unkeyed = "<leader>b";
            group = " Nvim Tree";
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
          {
            __unkeyed = "<leader>p";
            group = "Previews";
          }
          {
            __unkeyed = "<leader>h";
            group = "Hints";
          }
          {
            __unkeyed = "<leader>f";
            group = "File explorers";
          }

        ];
      };
    };
  };
}
