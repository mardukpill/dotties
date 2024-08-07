{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.${namespace}.cli.neovim;
in
{
  options.${namespace}.cli.neovim = {
    enable = mkEnableOption "neovim.";
  };

  imports = [ ./keymaps.nix ] ++ lib.snowfall.fs.get-non-default-nix-files ./plugins;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ripgrep
      neovide
    ];

    programs.nixvim = {
      enable = true;
      defaultEditor = true;

      viAlias = true;
      vimAlias = true;

      opts = {
        number = true;
        relativenumber = true;
        spell = true;
        spelllang = "en_us";
        expandtab = true;
        cursorline = true;
        undofile = true;

        shiftwidth = 2;
        tabstop = 2;
      };

      plugins = {
        fidget = {
          enable = true;
        };

        nvim-colorizer = {
          enable = true;
        };

        nvim-tree = {
          enable = true;
        };

        otter = {
          # TODO
          enable = true;
        };
      };

      extraPlugins = with pkgs.vimPlugins; [
        # add regular vim plugins here
      ];

      extraConfigLuaPre = # Lua
        ''
          require("otter").activate({ "python", "bash", "fish", "lua" }, true, true, nil)
          vim.g.neovide_scale_factor = 1.5
        '';
    };
  };
}
