{ pkgs ? import <nixpkgs> { } }:
let
  localpkgs = import ../../default.nix { };
  version = "v1.1";
  CMAKE_BUILD_TYPE = "Release";
in with pkgs;
stdenv.mkDerivation {

  name = "paho-mqtt-cpp";
  nativeBuildInputs = [ cmake ninja pkgconfig ];
  buildInputs = [ openssl localpkgs.paho-mqtt-c ];

  src = fetchFromGitHub {
    owner = "eclipse";
    repo = "paho.mqtt.cpp";
    rev = version;
    sha256 = "0qbwkfb8lvhkk3vfzggkg0jaahp7rqmhg10cy5jjaradgg0fmyly";
  };

  cmakeFlags = [
    "-DCMAKE_INSTALL_PREFIX=$out"
    "-DPAHO_BUILD_SHARED=TRUE"
    "-DPAHO_BUILD_STATIC=TRUE"
    "-DPAHO_WITH_SSL=TRUE"
    "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
    "-DPAHO_MQTT_C_LIBRARIES=${localpkgs.paho-mqtt-c}/lib/libpaho-mqtt3as.a"
  ];

  meta = {
    homepage = "https://eclipse.org/paho";
    description =
      "An Eclipse Paho C++ client library for MQTT for Windows, Linux and MacOS.";
    license = stdenv.lib.licenses.epl20;
    maintainers = with stdenv.lib.maintainers; [ ];
    platforms = stdenv.lib.platforms.unix;
  };
}
