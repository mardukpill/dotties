_: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      folding = true;
      nixvimInjections = true;

      settings = {
        highlight = {
          enable = true;
        };
      };
    };
    treesitter-refactor = {
      enable = true;

      highlightDefinitions = {
        enable = true;
        clearOnCursorMove = true;
      };
      smartRename = {
        enable = true;
      };
      navigation = {
        enable = true;
      };
    };
  };
}
