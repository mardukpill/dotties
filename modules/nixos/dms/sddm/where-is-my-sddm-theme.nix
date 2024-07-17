# https://github.com/Aman9das/zaneyos/blob/9deb3d0a7690f647b47b2ccd37a7028eae42d7e2/config/pkgs/where-is-my-sddm-theme.nix
{
  pkgs,
  namespace,
  config,
  ...
}:
let
  image =
    if (config.${namespace}.dms.sddm.theme.background == null) then
      pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath
    else
      config.${namespace}.dms.sddm.theme.background;
in
pkgs.stdenvNoCC.mkDerivation {
  name = "where-is-my-sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "stepanzubkov";
    repo = "where-is-my-sddm-theme";
    rev = "4e55b6a549b559e1d7d21b84e301e427d5b8d005";
    sha256 = "sha256-lxdtlNdMxBwCRL7c1Uw/TY6Yv9ycSdQz4BE1w19tzog=";
  };
  installPhase = # bash
    ''
      mkdir -p $out
      ls . -a
      cp -R ./where_is_my_sddm_theme_qt5/* $out/
      cd $out/
      #rm Background.jpg
      cp -r ${image} $out/background.jpg
      #rm theme.conf and set new conf
      cat <<EOT > theme.conf
      [General]
      # Password mask character
      passwordCharacter=●
      # Mask password characters or not ("true" or "false")
      passwordMask=true
      # value "1" is all display width, "0.5" is a half of display width etc.
      passwordInputWidth=0.9
      # Background color of password input
      passwordInputBackground=
      # Radius of password input corners
      passwordInputRadius=
      # "true" for visible cursor, "false"
      passwordInputCursorVisible=false
      # Font size of password (in points)
      passwordFontSize=24
      passwordCursorColor=random
      passwordTextColor=

      # Show or not sessions choose label
      showSessionsByDefault=false
      # Font size of sessions choose label (in points).
      sessionsFontSize=24

      # Show or not users choose label
      showUsersByDefault=true
      # Font size of users choose label (in points)
      usersFontSize=32

      # Path to background image
      background=background.jpg
      # Or use just one color
      backgroundFill=
      backgroundMode=aspect

      # Default text color for all labels
      basicTextColor=#fafafa

      # Radius of background blur
      blurRadius=16
      EOT
    '';
}
