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
  options.${namespace}.environments = {
    placeholder = mkBoolOpt true "placeholder";
  };
}
