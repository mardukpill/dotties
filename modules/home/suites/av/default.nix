{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.suites.av;
in
{
  options.${namespace}.suites.av = {
    enable = mkEnableOption "a suite of audio visual applications.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ffmpeg
      yt-dlp
      imagemagick
      viewnior
    ];

    dotties.apps = {
      imv = enabled;
      mpv = enabled;
    };
  };
}
