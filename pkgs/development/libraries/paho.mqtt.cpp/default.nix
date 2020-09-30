with import <nixpkgs> {};

let
  pahoC = import ../paho.mqtt.c/default.nix;

in

stdenv.mkDerivation rec {
  name = "paho.mqtt.cpp";

  src = fetchFromGitHub {
    owner = "eclipse";
    repo = "paho.mqtt.cpp";
    rev = "v1.1";
    sha256 = "0qbwkfb8lvhkk3vfzggkg0jaahp7rqmhg10cy5jjaradgg0fmyly";
  };

  makeFlags = [
    "LDCONFIG=echo"
    "PREFIX=$(out)"
    "LIBDIR=$(out)/lib"
    "INCLUDEDIR=$(out)/include"
    "DESTDIR=$(out)"
  ];

  installFlags = [
    "LDCONFIG=echo"
  ];

  preInstall = ''
  echo $out
  mkdir -p $out/usr/local/share/man/man1
  mkdir -p $out/usr/local/lib
  '';

  nativeBuildInputs = with pkgs; [ cmake ninja ];
  buildInputs = with pkgs;  [ openssl pahoC ];
  meta = {
    homepage = "https://eclipse.org/paho";
    description = "An Eclipse Paho C client library for MQTT for Windows, Linux and MacOS.";
    license = stdenv.lib.licenses.epl20;
    maintainers = with stdenv.lib.maintainers; [ ];
    platforms = stdenv.lib.platforms.unix;
  };
}
