{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
pkgs.stdenv.mkDerivation {
  name = "bluemail-with-gpu";
  phases = [ "installPhase" ];
  buildInputs = [ pkgs.makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp -r ${pkgs.bluemail}/* $out/
    substituteInPlace $out/share/applications/bluemail.desktop \
      --replace "Exec=bluemail" "Exec=bluemail-gpu"
    makeWrapper ${pkgs.bluemail}/bin/bluemail $out/bin/bluemail-gpu --add-flags "--in-process-gpu"
  '';
}
