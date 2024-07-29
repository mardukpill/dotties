{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.apps.bottles;
in
{
  options.${namespace}.apps.bottles = {
    enable = mkEnableOption "Bottles.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ bottles ];

    /*
      programs.nix-ld.enable = true;
      programs.nix-ld.libraries = with pkgs; [
      ];
    */
  };
}
