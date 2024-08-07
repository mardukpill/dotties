{
  lib,
  pkgs,
  namespace,
  system,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption types;
  inherit (lib.${namespace}) mkOpt;

  cfg = config.${namespace}.cli.fish;
in
{
  options.${namespace}.cli.fish = {
    enable = mkEnableOption "fish.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ripgrep
      bat
      fzf
      zoxide
    ];

    programs.fish = {
      enable = true;
      shellInit = ''
        set -g fish_greeting
        zoxide init fish | source

        set fish_greeting
      '';
      plugins = [
        {
          name = "fzf-fish";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
        {
          name = "fish-done";
          src = pkgs.fishPlugins.done.src;
        }
      ];
      functions = {
        fish_prompt = ./prompt.nix;
        fish_mode_prompt = ./fish_mode.nix;

        __fish_command_not_found_handler = {
          body = "__fish_default_command_not_found_handler $argv[1]";
          onEvent = "fish_command_not_found";
        };

        nxsh = {
          body = ''
            if test (count $argv) -eq 1
            	nix shell nixpkgs#$argv[1]
            else
            	echo "Usage: nxsh <package-name>"
            end
          '';
        };

      };
      interactiveShellInit = ''
        fish_vi_key_bindings
      '';
    };
  };
}
