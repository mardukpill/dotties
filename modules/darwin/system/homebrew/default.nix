# ./modules/darwin/system/homebrew/default.nix
{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  # Configuration alias
  cfg = config.${namespace}.system.homebrew;

  isDarwin = pkgs.stdenv.isDarwin;
in
{
  options.${namespace}.system.homebrew = {
    enable = mkEnableOption "Integrate Apple Homebrew (brew/cask) into the Nix-Darwin system.";
  };

  config = mkIf (cfg.enable && isDarwin) {
    homebrew = {
      enable = true;
      global.brewfile = true;
      onActivation.cleanup = "zap";

      brews = [
        "docker-compose"
      ];

      casks = [
        "firefox"
        "keepassxc"
        "docker"
        "notion"
        "docker-desktop"
        "iina"
        "hot"
        "wireshark"
      ];
    };

    # Ensure Homebrew's prefix comes early in PATH for interactive shells and
    # daemons.
    environment.systemPath = [
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
    ];

    # Link Homebrew's bin directory into the system profile so tools are
    # discoverable even outside interactive shells.
    environment.pathsToLink = [
      "/opt/homebrew/bin"
    ];
  };
}
