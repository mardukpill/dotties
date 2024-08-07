_: {
  programs.nixvim.plugins = {
    oil = {
      enable = true;
      settings = {
        float = {
          max_height = 25;
          max_width = 55;
        };
      };
    };
  };
}
