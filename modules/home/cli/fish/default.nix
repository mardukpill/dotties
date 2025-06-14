{
  lib,
  pkgs,
  namespace,
  system,
  config,
  ...
}:
let
  inherit (lib)
    mkIf
    mkEnableOption
    getExe
    ;
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
      nix-your-shell
    ];

    programs.fish = {
      enable = true;
      shellInit = ''
        set -g fish_greeting
        set -gx EDITOR nvim
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
          body = # fish
            ''
              if test (count $argv) -ge 1
                  set -l pkgs
                  for arg in $argv
                      set -a pkgs "nixpkgs#$arg"
                  end
                  nix shell $pkgs
              else
                  echo "Usage: nxsh <package-name> [<package-name>...]"
              end
            '';
        };
        tmp = {
          body = # fish
            ''
              cd (mktemp -d)
            '';
        };

        qz = {
          body = # fish
            ''
              zoxide query $argv[1]
            '';
        };

        nsfind = {
          body = # fish
            ''
              nix-store -q --graph /run/current-system/ | grep $argv[1]
            '';
        };
      };
      interactiveShellInit = # fish
        ''
          fish_vi_key_bindings
          ${getExe pkgs.nix-your-shell} fish | source
          ${getExe pkgs.zoxide} init fish | source
        ''
        + (
          if !pkgs.stdenv.hostPlatform.isLinux then
            ''export PATH=$HOME/.nix-profile/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin:/opt/homebrew/bin''
          else
            ''''
        );
    };
  };
}
