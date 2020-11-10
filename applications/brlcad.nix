{ pkgs ? import <nixpkgs> { } }:
let
  version = "7.32.0";
  CMAKE_BUILD_TYPE = "Release";
in with pkgs;
stdenv.mkDerivation {
  name = "BRL-CAD";

  src = fetchTarball {
    url =
      "https://sourceforge.net/projects/brlcad/files/BRL-CAD%20Source/7.32.0/brlcad-7.32.0.tar.bz2/download?use_mirror=master&r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fbrlcad%2Ffiles%2FBRL-CAD%2520Source%2F7.32.0%2F&use_mirror=master";
    sha256 = "0hvd5hslh4s9hidpkd5mg0r1fw43ba02mwswr73ki7c12dl7j04v";
  };
  cmakeFlags = [
    "-DCMAKE_INSTALL_PREFIX:PATH=/tmp"
    "-DBRLCAD_BUNDLED_LIBS=ON"
    "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
  ];
  nativeBuildInputs = [ cmake pkgconfig icu tcsh git wget curl ps file ];
  buildInputs =
    [ openssl icu gpgme ncurses zlib libconfig libelf libgpgerror libgcrypt ];

}
