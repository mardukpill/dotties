{ lib, ... }:
let
  inherit (lib) fetchFromGitHub;
in
final: prev: {
  gruvbox-plus-icons = prev.gruvbox-plus-icons.override {
    version = "6.1.1";
    src = fetchFromGitHub {
      owner = "SylEleuth";
      repo = "gruvbox-plus-icon-pack";
      rev = "v${final.version}";
      hash = "";
    };

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/icons
      cp -r Gruvbox-Plus-Dark $out/share/icons/
      gtk-update-icon-cache $out/share/icons/Gruvbox-Plus-Dark

      runHook postInstall
    '';
  };
}
