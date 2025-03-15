{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib)
    mkIf
    mkEnableOption
    types
    getExe
    ;
  inherit (lib.${namespace}) mkOpt;
  cfg = config.${namespace}.cli.neovim;
in
{
  options.${namespace}.cli.neovim = {
    enable = mkEnableOption "neovim.";
    latex = {
      enable = mkOpt types.bool true "LaTeX support for Neovim.";
    };
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
        foldmethod = "manual";

        shiftwidth = 2;
        tabstop = 2;
      };

      plugins = {
        fidget = {
          enable = true;
        };

        colorizer = {
          enable = true;
        };

        nvim-tree = {
          enable = true;
        };

        web-devicons = {
          enable = true;
        };
      };

      extraPlugins = with pkgs.vimPlugins; [
        # add regular vim plugins here
      ];

      extraConfigLuaPre = # Lua
        ''
          vim.o.shell = "${getExe pkgs.fish}"
          vim.g.neovide_scale_factor = 1.5
        '';

      performance = {
        byteCompileLua = {
          enable = true;
          nvimRuntime = true;
          configs = true;
          plugins = true;
        };
      };
    };
  };
}
