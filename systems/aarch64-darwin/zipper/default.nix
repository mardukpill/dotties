{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.user;
in
{

  environment.systemPath = [ "/opt/homebrew/bin" ];

  networking = {
    computerName = "Mike MacBook";
    hostName = "zipper";
    localHostName = "zipper";

    knownNetworkServices = [
      "Wi-Fi"
      "Thunderbolt Bridge"
    ];
  };

  nix.settings = {
    cores = 16;
    max-jobs = 8;
  };

  system = {
    primaryUser = "mike";
    stateVersion = 5;
  };
}
