{ pkgs ? import <nixpkgs> { } }:
let
  version = "r1.30";
  CMAKE_BUILD_TYPE = "Release";
  routines_dir = "/var/lib/yottadb/${version}/r";
  globals_dir = "/var/lib/yottadb/${version}/g";
in with pkgs;
stdenv.mkDerivation {
  name = "yottadb";

  src = fetchTarball {
    url =
      "https://gitlab.com/YottaDB/DB/YDB/-/archive/${version}/YDB-${version}.tar.bz2";
    sha256 = "0gq7rikbzz439xwb7jy8m6a716gkr7zdkly7zq680lrv79v4wvf6";
  };

  patches = [ ./noroot.patch ];

  preConfigure = ''
    export LD_LIBRARY_PATH=${icu}/lib:${openssl}/lib:${zlib}/lib
    ulimit -n 4096
  '';

  cmakeFlags = [
    "-DCMAKE_INSTALL_PREFIX:PATH=/tmp"
    "-DYDB_INSTALL_DIR:STRING=yottadb-release"
    "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
  ];

  postFixup = ''
    cd /tmp/yottadb-release/
    ./ydbinstall --installdir=$out/bin --force-install --user nixbld --group nixbld
  '';

  nativeBuildInputs = [ cmake pkgconfig icu tcsh git wget curl ps file ];
  buildInputs =
    [ openssl icu gpgme ncurses zlib libconfig libelf libgpgerror libgcrypt ];

}
