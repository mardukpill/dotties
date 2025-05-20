{
  pkgs,
  lib,
  namespace,
  options,
  ...
}:
let
  inherit (lib.${namespace}) mkBoolOpt;
  opt = options.${namespace}.environments;
in
{
  opt = {
    placeholder = mkBoolOpt true "placeholder";
  };
}
