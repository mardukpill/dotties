{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  theme = config.${namespace}.wms.theme;
in
{
  programs.nixvim = {
    colorschemes = {
      rose-pine = mkIf (theme == "rose-pine") {
        enable = true;
        settings = {
          variant = "main";
        };
      };
      gruvbox = mkIf (theme == "acrylic") {
        enable = true;
        settings = {
          variant = "light";
        };
      };
    };

    # Extra themes
    extraPlugins = with pkgs.vimUtils; [
      (buildVimPlugin {
        pname = "challenger-deep-theme";
        version = "25-apr-2022";
        src = pkgs.fetchFromGitHub {
          owner = "challenger-deep-theme";
          repo = "vim";
          rev = "e3d5b7d9711c7ebbf12c63c2345116985656da0d";
          hash = "sha256-2lIPun5OjaoHSG2BdnX9ztw3k9whVlBa9eB2vS8Htbg=";
        };
      })
    ];
  };
}
