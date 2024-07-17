{ inputs, ... }:
let
  inherit (inputs) nixvim;
in
{
  programs.nixvim.plugins.leap = {
    enable = true;
  };
}
