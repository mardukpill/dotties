_: {
  programs.nixvim = {

    plugins = {
      toggleterm = {
        enable = true;
        settings.direction = "float";
      };
    };
  };
}
