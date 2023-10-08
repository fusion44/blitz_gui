{
  description = "Flutter 3.13.4";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShell =
          with pkgs; mkShell rec {
            buildInputs = [
              flutter-unwrapped
            ];

            shellHook = ''
              echo "Adding \$HOME/.pub-cache/bin to \$PATH"
              export PATH="$PATH":"$HOME/.pub-cache/bin"
              echo "Disabling all Dart and Flutter analytics"
              dart --disable-analytics > /dev/null
              flutter config --no-analytics > /dev/null
              echo "Activating melos ..."
              dart pub global activate melos > /dev/null
            '';
          };
      });
}
