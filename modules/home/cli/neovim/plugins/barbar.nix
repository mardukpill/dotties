{inputs, ...}: let
	inherit (inputs) nixvim;
in {
  programs.nixvim.plugins.barbar = {
    enable = true;
    keymaps = {
      previous = "<leader>tk";
      next = "<leader>tj";
      movePrevious = "<leader>th";
      moveNext = "<leader>tl";
      goTo1 = "<leader>t1";
      goTo2 = "<leader>t2";
      goTo3 = "<leader>t3";
      goTo4 = "<leader>t4";
      goTo5 = "<leader>t5";
      goTo6 = "<leader>t6";
      goTo7 = "<leader>t7";
      goTo8 = "<leader>t8";
      goTo9 = "<leader>t9";
      last = "<leader>tL";
      # close = "<leader>tq";
    };
    sidebarFiletypes = {NvimTree = true;};
  };
}
