{ pkgs, ... }:
let
  stdenv = pkgs.stdenv;
  lib = pkgs.lib;
  fs = lib.fileset;
  #zigpkgs = zig.packages.x86_64-linux.master;
  sourceFiles = fs.unions [
    ./build.zig.zon
    (fs.fileFilter
      (file:
        lib.hasSuffix ".zig" file.name
      )
      ./.
    )
  ];
in

fs.trace sourceFiles

stdenv.mkDerivation {
  pname = "zig-sqlite-source";
  version = "0.1.0";
  src = fs.toSource {
    root = ./.;
    fileset = sourceFiles;
  };

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp -r $src/* $out
  '';
}

