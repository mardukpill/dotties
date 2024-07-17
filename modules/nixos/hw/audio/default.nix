{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkOption mkIf;

  cfg = config.${namespace}.hw.audio;
in
{
  options.${namespace}.hw.audio = {
    provider = mkOption {
      type = lib.types.enum [ "pipewire" ];
      default = "pipewire";
      description = "which audio provider to use.";
    };
  };

  imports = [ ./pipewire.nix ];
  config = mkIf (cfg.provider != "") {
    # mkIf (cfg.provider == "pipewire") [ ./pipewire.nix ];
  };
}
