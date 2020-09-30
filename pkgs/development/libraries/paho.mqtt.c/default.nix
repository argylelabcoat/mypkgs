with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "paho.mqtt.c";

  src = fetchFromGitHub {
    owner = "eclipse";
    repo = "paho.mqtt.c";
    rev = "v1.3.5";
    sha256 = "04zk27qgakmqydqhp6nnj3c58c2115p4z6aalcih6jz44kj9927m";
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

  buildInputs = with pkgs;  [ openssl ];
  meta = {
    homepage = "https://eclipse.org/paho";
    description = "An Eclipse Paho C client library for MQTT for Windows, Linux and MacOS.";
    license = stdenv.lib.licenses.epl20;
    maintainers = with stdenv.lib.maintainers; [ ];
    platforms = stdenv.lib.platforms.unix;
  };
}
