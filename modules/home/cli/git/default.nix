{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkOpt;

  cfg = config.${namespace}.cli.git;
in
{
  options.${namespace}.cli.git = {
    manage = mkOpt types.bool true "whether to manage git home configuration";
  };

  config = mkIf cfg.manage {
    programs.lazygit = {
      enable = true;
    };

    programs.git = {
      enable = true;

      delta = {
        enable = true;

        options = {
          dark = true;
          line-numbers = true;
        };
      };

      extraConfig = {
        init = {
          defaultBranch = "main";
        };

        push = {
          autoSetupRemote = true;
        };
      };
    };
  };
}
