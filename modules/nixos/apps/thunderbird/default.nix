{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkIf mkOption;
  inherit (lib.${namespace}) mkOpt;

  cfg = config.${namespace}.apps.thunderbird;
in
{
  options.${namespace}.apps.thunderbird = {
    enable = mkOpt lib.types.bool false "whether to enable thunderbird mail client.";
    exchangeSupport = mkOpt lib.types.bool true "whether to enable exchange support for mail clients";
  };

  config = mkIf cfg.enable {
    programs.thunderbird.enable = true;

    services.davmail = mkIf cfg.exchangeSupport {
      enable = true;
      url = "https://outlook.office365.com/EWS/Exchange.asmx";
    };
  };

}
