_: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
    };

    keymaps = [
      # telescope
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>sg";
        options.desc = "Telescope live grep";
      }
      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader>sf";
        options.desc = "Telescope find files";
      }
      {
        action = "<cmd>Telescope buffers<CR>";
        key = "<leader><leader>";
        options.desc = "Telescope buffers";
      }
      {
        action = "<cmd>Telescope workspaces<CR>";
        key = "<leader>ws";
        options.desc = "Telescope workspaces";
      }

      # nvim-tree
      {
        key = "<leader>bt";
        action = ":NvimTreeToggle<CR>";
        options.desc = "NvimTreeToggle";
      }
      {
        key = "<leader>br";
        action = ":NvimTreeRefresh<CR>";
        options.desc = "NvimTreeRefresh";
      }
      {
        key = "<leader>bf";
        action = ":NvimTreeFindFile<CR>";
        options.desc = "NvimTreeFindFile";
      }
      # bindings that should be default
      {
        key = "<leader>y";
        action = "\"+y";
        options.desc = "Yank into clipboard";
      }
      {
        key = "<leader>v";
        action = "\"+p";
        options.desc = "Paste from clipboard";
      }
      {
        mode = "n";
        key = "<esc>";
        action = ":noh<CR>";
        options.silent = true;
      }
      /*
        {
          key = "<jk>"; # FIXME: binding does not work
          action = "<Esc>";
          mode = "i";
          options.desc = "Emergency exit for insert mode";
        }
      */
      {
        key = "<C-Space>";
        mode = "t";
        action = "<C-\\><C-n>";
        options.desc = "Exit terminal mode";
      }
      {
        mode = "n";
        key = "<leader>pg";
        action = "<cmd>Glow<CR>";
        options.desc = "Preview current markdown document in Glow.";
      }
      {
        mode = "n";
        key = "<leader>pp";
        action = "<cmd>VimtexCompile<CR>";
        options = {
          silent = true;
          desc = "Live preview current LaTeX document in Zathura.";
        };
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = {
          __raw = # Lua
            ''
              function() require("oil").open_float() end
            '';
        };
        options.desc = "Open a floating Oil instance";
      }
      {
        mode = "n";
        key = "<leader>fhp";
        action = {
          __raw = # Lua
            ''
              function() require("oil").open_preview({horizontal=true}) end
            '';
        };
        options.desc = "Open a preview of the file selected in Oil (horizontal split)";
      }
      {
        mode = "n";
        key = "<leader>fp";
        action = {
          __raw = # Lua
            ''
              function() require("oil").open_preview() end
            '';
        };
        options.desc = "Open a preview of the file selected in Oil.";
      }
      {
        mode = "n";
        key = "<leader>fe";
        action = "<cmd>e %:h<CR>";
        options = {
          silent = true;
          desc = "Open the current file's parent directory in Oil.";
        };
      }
      {
        mode = "n";
        key = "<leader>fE";
        action = "<cmd>vs | vertical resize 40 | e %:h<CR>";
        options = {
          silent = true;
          desc = "Open the current file's parent directory in Oil (new vertical split).";
        };
      }
      {
        mode = "n";
        key = "<leader>,";
        action = ":%s/\(.*\)";
        options = {
          desc = "Start a find and replace command.";
        };
      }
      {
        mode = "n";
        key = "<leader>tt";
        action = "<cmd>ToggleTerm<CR>";
        options = {
          desc = "Open a floating terminal.";
          silent = true;
        };
      }
    ];
  };
}
