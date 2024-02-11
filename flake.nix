{
  description = "Jaspr Flutter Dev Environment";
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
              flutter
              nodejs_21
              just
              sshpass # for the pi deploy script
              llvmPackages_latest.libcxxClang
              llvmPackages_latest.llvm
              gtk3
              pkg-config
              ninja
              xorg.libX11
              rnix-lsp
              nixpkgs-fmt
            ];

            shellHook = ''
              echo "Adding \$HOME/.pub-cache/bin to \$PATH"
              export PATH="$PATH":"$HOME/.pub-cache/bin"
              echo "Disabling Dart analytics"
              dart --disable-analytics > /dev/null
              echo "Disabling Flutter analytics"
              flutter --disable-analytics > /dev/null
              echo "Activating melos ..."
              dart pub global activate melos > /dev/null
            '';
          };
      });
}

