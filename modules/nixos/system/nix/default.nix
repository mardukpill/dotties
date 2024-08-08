{
  pkgs,
  namespace,
  lib,
  inputs,
  config,
  ...
}:
with lib;
let
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.system.nix;
in
{
  options.${namespace}.system.nix = {
    managed = mkOption {
      type = lib.types.bool;
      default = true;
      description = "whether to manage nix configuration.";
    };
    useHelper = mkEnableOption "whether to use nix helper.";
    comma = mkEnableOption "comma.";
  };

  config = mkIf cfg.managed {
    environment.systemPackages = with pkgs; [
      home-manager
      sqlite
    ];

    programs.nix-index-database.comma.enable = cfg.comma;

    programs.nh = mkIf cfg.useHelper enabled;

    nix =
      let
        flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
      in
      {
        settings = {
          experimental-features = "nix-command flakes";
          flake-registry = "";
          # Workaround for https://github.com/NixOS/nix/issues/9574
          nix-path = "https://github.com/NixOS/nixpkgs";
          substituters = [
            "https://nix-community.cachix.org"
            "https://cache.nixos.org/"
          ];
          trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
        };
        channel.enable = false;

        generateRegistryFromInputs = true;
        generateNixPathFromInputs = true;
        linkInputs = true;

        # registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs; # nix3
        # nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs; # nix2

        gc = {
          automatic = true;
          options = "--delete-older-than 7d";
        };
      };
    nixpkgs = {
      config = {
        allowUnfree = true;
      };
    };
  };
}
