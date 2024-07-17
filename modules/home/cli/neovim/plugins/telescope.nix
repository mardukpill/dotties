{ inputs, ... }:
let
  inherit (inputs) nixvim;
in
{
  programs.nixvim.plugins.telescope = {
    enable = true;
  };
}
