{
  pkgs,
  lib,
  config,
  namespace,
  osConfig,
  inputs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) defineCssColors;
  inherit (inputs) anyrun-nixos-options;

  theme = config.${namespace}.wms.theme;
  palette = config.colorScheme.palette;

  cfg = config.${namespace}.utility.anyrun;

  themes = {
    "rose-pine" = {
      width.fraction = 0.2;
      y.fraction = 0.2;
    };
    "acrylic" = {
      x.fraction = 0.125;
      y.fraction = 0.5;
      height.fraction = 1.0;
      width.fraction = 0.25;
    };
  };
in
{
  options.${namespace}.utility.anyrun = {
    enable = mkEnableOption "anyrun.";
  };

  config = mkIf cfg.enable {
    programs.anyrun = {
      enable = true;
      config = {
        plugins = builtins.map (p: "${config.programs.anyrun.package}${p}") [
          "/lib/libapplications.so"
          "/lib/libdictionary.so"
          "/lib/librink.so"
          "/lib/libshell.so"
          "/lib/libsymbols.so"
          "/lib/libstdin.so"
          "/lib/libtranslate.so"
          "/lib/libwebsearch.so"
        ];
        maxEntries = 10;

        hidePluginInfo = true;
        closeOnClick = true;
      } // themes.${theme};
      extraCss = (defineCssColors palette) + builtins.readFile ./themes/${theme}.css;

      extraConfigFiles = {
        "applications.ron".text = ''
          Config(
            desktop_actions: true,
            max_entries: 10,
            terminal: Some("alacritty"),
          )
        '';

        "nixos-options.ron".text =
          let
            nixos-options = osConfig.system.build.manual.optionsJSON + "/share/doc/nixos/options.json";
            options = builtins.toJSON { ":nix" = [ nixos-options ]; };
          in
          ''
            Config(
              options: ${options},
              min_score: 5,
              max_entries: Some(3),
            )
          '';

        "symbols.ron".text = ''
          Config(
            prefix: ":sy",
            symbols: {
              "shrug": "¯\\_(ツ)_/¯",
            },
            max_entries: 20,
          )
        '';

        # <prefix><target lang> <text to translate>
        "translate.ron".text = ''
          Config(
            prefix: ":tr",
            language_delimiter: ">",
            max_entries: 3,
          )
        '';

        "websearch.ron".text = ''
          Config(
            prefix: "?",
            engines: [Google]
          )
        '';
      };
    };
  };
}
