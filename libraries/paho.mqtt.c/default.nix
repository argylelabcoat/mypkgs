{ pkgs ? import <nixpkgs>{} }:
with pkgs;
stdenv.mkDerivation {
  name = "paho-mqtt-c";

  src = fetchFromGitHub {
    owner = "eclipse";
    repo = "paho.mqtt.c";
    rev = "v1.3.5";
    sha256 = "04zk27qgakmqydqhp6nnj3c58c2115p4z6aalcih6jz44kj9927m";
  };


  # if [ -d "source/build" ]; then rm -Rf source/build; fi
  # mkdir source/build
  # cd source/build

  configurePhase = ''
  cmake -GNinja -DCMAKE_INSTALL_PREFIX=$out -DPAHO_BUILD_SHARED=TRUE -DPAHO_BUILD_STATIC=FALSE -DPAHO_WITH_SSL=TRUE .
  '';

  buildPhase = ''
  ninja
  '';
 

  installPhase = ''
  CMAKE_INSTALL_PREFIX=$out ninja install 
  '';

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
