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

  cfg = config.${namespace}.ai.ollama;
in
{
  options.${namespace}.ai.ollama = {
    enable = mkEnableOption "ollama.";
  };

  config = mkIf cfg.enable {
    services = {
      ollama = {
        enable = true;
        acceleration = "cuda";
        loadModels = [
          # https://ollama.com/library
        ];
      };
      nextjs-ollama-llm-ui = enabled;
    };

  };
}
