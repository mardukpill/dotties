{
  lib,
  pkgs,
  inputs,
  namespace,
  config,
  ...
}:
let
  inherit (lib)
    mkIf
    mkOption
    mkEnableOption
    enabled
    ;

  cfg = config.${namespace}.apps.mpv;
in
{
  options.${namespace}.apps.mpv = {
    enable = mkEnableOption "mpv.";
  };

  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      config = {
        vo = "gpu-next";
        hwdec = "auto";
        hwdec-codecs = "all";
        profile = "gpu-hq";
        scale = "ewa_lanczossharp";
        cscale = "ewa_lanczossharp";
      };
    };

    xdg.mimeApps.defaultApplications = lib.mkIf pkgs.stdenv.isLinux {
      "audio/*" = [ "mpv.desktop" ];
      "video/*" = [ "mpv.desktop" ];
    };
  };
}
