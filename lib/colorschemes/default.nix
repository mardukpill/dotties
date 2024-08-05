{ lib, ... }:
with lib;
rec {
  defineCssColors = palette: ''
    @define-color background #${palette.base00};
    @define-color base01 #${palette.base01};
    @define-color base02 #${palette.base02};
    @define-color base03 #${palette.base03};
    @define-color base04 #${palette.base04};
    @define-color base05 #${palette.base05};
    @define-color base06 #${palette.base06};
    @define-color foregroundalt #${palette.base07};
    @define-color backgroundalt #${palette.base08};
    @define-color base09 #${palette.base09};
    @define-color base0A #${palette.base0A};
    @define-color base0B #${palette.base0B};
    @define-color base0C #${palette.base0C};
    @define-color base0D #${palette.base0D};
    @define-color base0E #${palette.base0E};
    @define-color foreground #${palette.base0F};
  '';
}
