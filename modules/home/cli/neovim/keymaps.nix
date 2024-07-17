{ inputs, ... }:
let
  inherit (inputs) nixvim;
in
{
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
        key = "<jk>"; # FIXME: binding does not work
        action = "<Esc>";
        mode = "i";
        options.desc = "Emergency exit for insert mode";
      }
      {
        key = "<C-Esc>";
        mode = "t";
        action = "<C-\\><C-n>";
        options.desc = "Exit terminal mode";
      }
    ];
  };
}
