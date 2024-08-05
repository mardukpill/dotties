{
  pkgs,
  lib,
  namespace,
  ...
}:
pkgs.writeShellScriptBin "hi" ''
  echo "Hello from dotties!"
''
