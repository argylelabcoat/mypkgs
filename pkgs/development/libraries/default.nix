{ system ? builtins.currentSystem } :
let
  pkgs = import <nixpkgs>{ inherit system; };
in rec {
  paho-mqtt-c = pkgs.callPackage ./paho.mqtt.c/default.nix { inherit pkgs; };
  paho-mqtt-cpp = pkgs.callPackage ./paho.mqtt.cpp/default.nix { inherit pkgs; };
}
