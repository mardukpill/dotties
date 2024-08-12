{
  pkgs,
  config,
  lib,
  namespace,
  fetchurl,
  ...
}:
pkgs.stdenv.mkDerivation {
  name = "bluemail-with-gpu";
  phases = [ "installPhase" ];
  buildInputs = [ pkgs.makeWrapper ];
  src = fetchurl {
    # use updated version of bluemail
    url = "https://download.bluemail.me/BlueMail/deb/BlueMail.deb";
    hash = "sha256-dnYOb3Q/9vSDssHGS2ywC/Q24Oq96/mvKF+eqd/4dVw=";
  };
  installPhase = ''
    mkdir -p $out/bin
    cp -r ${pkgs.bluemail}/* $out/
    substituteInPlace $out/share/applications/bluemail.desktop \
      --replace "Exec=bluemail" "Exec=bluemail-gpu"
    makeWrapper ${pkgs.bluemail}/bin/bluemail $out/bin/bluemail-gpu --add-flags "--in-process-gpu"
  '';
}
