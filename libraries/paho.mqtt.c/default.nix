{ pkgs ? import <nixpkgs>{} }:
let
  version = "v1.3.5";
  CMAKE_BUILD_TYPE = "Release";
in with pkgs;
stdenv.mkDerivation {
  name = "paho-mqtt-c";

  src = fetchFromGitHub {
    owner = "eclipse";
    repo = "paho.mqtt.c";
    rev = version;
    sha256 = "04zk27qgakmqydqhp6nnj3c58c2115p4z6aalcih6jz44kj9927m";
  };

  cmakeFlags = [
    "-DCMAKE_INSTALL_PREFIX=$out" 
    "-DPAHO_BUILD_SHARED=TRUE"
    "-DPAHO_BUILD_STATIC=TRUE" 
    "-DPAHO_WITH_SSL=TRUE"
    "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
  ];

  nativeBuildInputs = [ cmake ninja pkgconfig ];
  buildInputs = [ openssl ];
  meta = {
    homepage = "https://eclipse.org/paho";
    description = "An Eclipse Paho C client library for MQTT for Windows, Linux and MacOS.";
    license = stdenv.lib.licenses.epl20;
    maintainers = with stdenv.lib.maintainers; [ ];
    platforms = stdenv.lib.platforms.unix;
  };
}
