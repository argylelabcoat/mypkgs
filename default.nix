{ system ? builtins.currentSystem }:
let pkgs = import <nixpkgs> { inherit system; };
in rec {
  paho-mqtt-c =
    pkgs.callPackage ./libraries/paho.mqtt.c/default.nix { inherit pkgs; };
  paho-mqtt-cpp =
    pkgs.callPackage ./libraries/paho.mqtt.cpp/default.nix { inherit pkgs; };
  yottadb = pkgs.callPackage ./databases/yottadb/default.nix { inherit pkgs; };
  brlcad = pkgs.callPackage ./applications/brlcad.nix { inherit pkgs; };
}
