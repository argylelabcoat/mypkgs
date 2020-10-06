{ pkgs ? import <nixpkgs>{} }:
let
  localpkgs = import ../../default.nix {};
in

with pkgs;
stdenv.mkDerivation {

  name = "paho-mqtt-cpp";
  nativeBuildInputs = with pkgs; [ cmake ninja pkgconfig ];
  buildInputs = [ pkgs.openssl localpkgs.paho-mqtt-c ];


  src = fetchFromGitHub {
    owner = "eclipse";
    repo = "paho.mqtt.cpp";
    rev = "v1.1";
    sha256 = "0qbwkfb8lvhkk3vfzggkg0jaahp7rqmhg10cy5jjaradgg0fmyly";
  };

  configurePhase = ''
  cmake -GNinja -DCMAKE_INSTALL_PREFIX=$out -DPAHO_BUILD_SHARED=TRUE -DPAHO_BUILD_STATIC=FALSE -DPAHO_WITH_SSL=TRUE .
  '';

  buildPhase = ''
  ninja
  '';


   meta = {
    homepage = "https://eclipse.org/paho";
    description = "An Eclipse Paho C++ client library for MQTT for Windows, Linux and MacOS.";
    license = stdenv.lib.licenses.epl20;
    maintainers = with stdenv.lib.maintainers; [ ];
    platforms = stdenv.lib.platforms.unix;
  };
}
