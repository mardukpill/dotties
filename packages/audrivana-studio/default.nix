{
  pkgs,
  config,
  lib,
  namespace,
  fetchurl,
  ...
}:
pkgs.stdenv.mkDerivation {
  name = "Audirvana Studio";

  src = fetchurl {
    url = "https://audirvana.com/delivery/AudirvanaLinux.php?product=studio&arch=amd64&distrib=deb";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  nativeBuildInputs = with pkgs; [ dpkg ];

  unpackPhase = ''
    dpkg -x $src ./
  '';

  installPhase = ''

  '';
}
