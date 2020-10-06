{ pkgs ? import <nixpkgs>{} }:

with pkgs;
stdenv.mkDerivation {
  name = "yottadb";

  src = fetchTarball {
    url = https://gitlab.com/YottaDB/DB/YDB/-/archive/r1.30/YDB-r1.30.tar.bz2;
    sha256 = "0gq7rikbzz439xwb7jy8m6a716gkr7zdkly7zq680lrv79v4wvf6";
  };

  configurePhase = ''
  export LD_LIBRARY_PATH=${icu}/lib:${openssl}/lib:${zlib}/lib
  if [ -d "build" ]; then rm -rf "build"; fi
  mkdir build
  cd build
  cmake -GNinja -DCMAKE_INSTALL_PREFIX=$out   ..
  '';

  # export LD_LIBRARY_PATH=
  
  buildPhase = ''
  ulimit -n 4096
  ninja
  '';

  installPhase = ''
  CMAKE_INSTALL_PREFIX=$out ninja install 
  '';

  nativeBuildInputs = [ cmake ninja pkgconfig icu tcsh git ];
  buildInputs = [ openssl icu gpgme ncurses zlib libconfig libelf libgpgerror libgcrypt  ];

}
