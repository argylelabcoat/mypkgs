{ pkgs ? import <nixpkgs> { } }:
let mypkgs = import ./default.nix { };
in pkgs.mkShell {

  #    mypkgs.paho-mqtt-cpp ]
  buildInputs = [
    # apps
    # mypkgs.brlcad
    # db
    mypkgs.yottadb
    # mqtt
    mypkgs.paho-mqtt-c

    mypkgs.paho-mqtt-cpp
  ];
  shellHook = ''
    export ydb_dist=${mypkgs.yottadb}/bin
    export ydb_dir=/var/lib/yottadb
    export ydb_global_dir=/var/lib/yottadb/g
    export ydb_gbldir=$ydb_global_dir/yottadb.gld
    export ydb_routines=$ydb_dir/r1.30/routines
    export ydb_log=/var/log/yottadb
    ls ${mypkgs.paho-mqtt-c}/lib
  '';

  # sudo mkdir -p $ydb_routines
  # sudo mkdir -p $ydb_global_dir
  # sudo chown -R $USER:$USER $ydb_dir
  # sudo cp $ydb_dist/*.o $ydb_routines/
  # sudo cp $ydb_dist/*.m $ydb_routines/

}
