{
  pkgs,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) getExe;
  inherit (lib.${namespace}) enabled;
in
{
  programs.nixvim.plugins = {
    nix = enabled;
    otter = enabled;
    lsp-format = enabled;
    lsp = {
      enable = true;
      servers = {
        lua_ls = {
          enable = true;
          filetypes = [ "lua" ];
          settings = {
            telemetry.enable = false;
          };
        };
        phpactor = {
          enable = true;
          filetypes = [
            "php"
          ];
        };
        ts_ls = {
          enable = true;
          filetypes = [
            "javascript"
            "javascriptreact"
            "typescript"
            "typescriptreact"
          ];
        };

        clangd = {
          enable = true;

          extraOptions = {
            init_options = {
              usePlaceholders = true;
              completeUnimported = true;
              clangdFileStatus = true;
            };
          };
          cmd = [
            "clangd"
            "--background-index"
            "--clang-tidy"
            "--header-insertion=iwyu"
            "--completion-style=detailed"
            "--function-arg-placeholders"
            "--fallback-style=llvm"
          ];
        };

        # ccls = {
        #   enable = true;
        #   filetypes = [
        #     "c"
        #     "cpp"
        #   ];
        # };

        texlab = {
          enable = true;
          filetypes = [
            "latex"
            "tex"
          ];
        };

        # cssls = {
        #   enable = true;
        #   filetypes = [ "css" ];
        # };

        pyright = {
          enable = true;
          filetypes = [ "python" ];
        };

        nil_ls = {
          enable = true;
          filetypes = [ "nix" ];
          settings = {
            # formatting = {
            #   command = [ "${getExe pkgs.nixfmt-rfc-style}" ];
            # };
          };
        };

        ltex = {
          enable = true;
          filetypes = [
            "latex"
            "tex"
          ];
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
