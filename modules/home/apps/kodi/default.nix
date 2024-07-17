{
  config,
  lib,
  namespace,
  inputs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.${namespace}.apps.kodi;
in
{
  options.${namespace}.apps.kodi = {
    enable = mkEnableOption "kodi.";
  };

  config = mkIf cfg.enable {
    programs.kodi = {
      enable = true;
      sources = {
        files = {
          source = [
            {
              name = "nixgates repository";
              path = "https://nixgates.github.io/packages/";
            } # http://bit.ly/a4kScrapers
            {
              name = "a4k openproject";
              path = "https://a4k-openproject.github.io/";
            }
          ];
        };
      };
    };
  };
}
