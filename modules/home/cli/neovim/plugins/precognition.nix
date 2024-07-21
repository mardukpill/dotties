{ pkgs, ... }:
{
  # https://github.com/khaneliman/khanelinix/blob/f7f59d409cf913dd7083acf19f8cffdec957a7bb/modules/home/programs/terminal/editors/neovim/plugins/precognition.nix
  programs.nixvim = {
    extraPlugins = [ pkgs.vimPlugins.precognition-nvim ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>uP";
        action.__raw = ''
          function()
            if require("precognition").toggle() then
                vim.notify("precognition on")
            else
                vim.notify("precognition off")
            end
          end
        '';

        options = {
          desc = "Precognition Toggle";
          silent = true;
        };
      }
    ];
  };
}
