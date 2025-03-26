{ lib, ... }:
let
  inherit (lib) fetchFromGitHub;
in
final: prev: {
  maiko = prev.maiko.override {
    version = "2025-01-29";
    src = fetchFromGitHub {
      owner = "Interlisp";
      repo = "maiko";
      rev = "04f9905ca0fb47c4ee364e3e4218efb569ee9604";
      hash = "sha256-Y+ngep/xHw6RCU8XVRYSWH6S+9hJ74z50pGpIqS2CjM=";
    };
  };
}
