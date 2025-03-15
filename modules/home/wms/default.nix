{
  config,
  options,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) types;
  inherit (lib.${namespace}) mkOpt;
  cfg = config.${namespace}.wms;
in
{
  options.${namespace}.wms = {
    theme = mkOpt (types.enum [
      "rose-pine"
      "acrylic"
    ]) "rose-pine" "The window manager theme to use.";
  };
}
