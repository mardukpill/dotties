{inputs, ...}: let
	inherit (inputs) nixvim;
in {
  programs.nixvim.plugins = {
    luasnip.enable = true;

    cmp = {
      enable = true;
      settings = {
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

        sources = [
          {name = "luasnip";}
          {name = "path";}
          {name = "buffer";}
          {name = "nvim_lsp";}
					{name = "otter";}
        ];
        mapping = {
          "<C-d>" =
            # lua
            "cmp.mapping.scroll_docs(-4)";
          "<C-f>" =
            # lua
            "cmp.mapping.scroll_docs(4)";
          "<C-Space>" =
            # lua
            "cmp.mapping.complete()";
          "<C-e>" =
            # lua
            "cmp.mapping.close()";
          "<Tab>" =
            # lua
            "cmp.mapping(cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}), {'i', 's'})";
          "<S-Tab>" =
            # lua
            "cmp.mapping(cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}), {'i', 's'})";
          "<CR>" =
            # lua
            "cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })";
        };

        preselect =
          # lua
          "cmp.PreselectMode.None";
      };
    };
  };
}