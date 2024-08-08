{
  pkgs,
  lib,
  inputs,
  system,
  config,
  ...
}:
let
  inherit (lib) getExe;
in
{
  programs.nixvim.plugins = {
    nix.enable = true;
    lsp-format = {
      enable = true;
    };
    lsp = {
      enable = true;
      servers = {
        lua-ls = {
          enable = true;
          filetypes = [ "lua" ];
          settings = {
            telemetry.enable = false;
          };
        };

        nil-ls = {
          enable = true;
          filetypes = [ "nix" ];
          settings = {
            formatting = {
              command = [ "${getExe pkgs.nixfmt-rfc-style}" ];
            };
          };
          nix = {
            flake = {
              autoArchive = true;
            };
          };
        };

        bashls = {
          enable = true;
          filetypes = [
            "sh"
            "bash"
          ];
        };

        marksman = {
          enable = true;
          filetypes = [ "markdown" ];
        };
      };
      keymaps = {
        silent = true;
        diagnostic = {
          "<leader>k" = "goto_prev";
          "<leader>j" = "goto_next";
        };
        lspBuf = {
          "gd" = "definition";
          "gD" = "declaration";
          "gi" = "implementation";
          "gr" = "references";
          "gt" = "type_definition";
          "K" = "hover";

          "<C-k>" = "signature_help";

          "<leader>ca" = "code_action";
          "<leader>rn" = "rename";
          "<leader>wa" = "add_workspace_folder";
          "<leader>wr" = "remove_workspace_folder";
        };
      };
    };
  };
}
