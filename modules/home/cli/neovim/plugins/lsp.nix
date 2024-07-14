{inputs, ...}:  let
	inherit (inputs) nixvim;
in {
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      lua-ls = {
        enable = true;
        filetypes = ["lua"];
        settings = {
          telemetry.enable = false;
        };
      };
      nil-ls = {
        enable = true;
        filetypes = ["nix"];
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
}
