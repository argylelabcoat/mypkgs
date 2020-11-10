{ pkgs ? import <nixpkgs>{} }:
let
  version = "3.0.2996";
  CMAKE_BUILD_TYPE = "Release";
in with pkgs;
stdenv.mkDerivation rec {
  name = "azure-functions-core-tools";


  buildInputs = [ dotnetbuildhelpers unzip makeWrapper ];
  nativeBuildInputs = [ dotnetCorePackages.sdk_3_1 icu libunwind coreclr curl zlib ];
  rpath = stdenv.lib.makeLibraryPath [ libunwind coreclr libuuid stdenv.cc.cc curl zlib icu ];

  src = fetchurl {
      url = "https://github.com/Azure/azure-functions-core-tools/releases/download/3.0.2996/Azure.Functions.Cli.linux-x64.${version}.zip";
      sha256 = "164a6d2f983d2fb106cbe94069b94fbc2729d347c63799ef9e8d2bb16553254c";
  };


  unpackPhase = ''
    runHook preUnpack;
    ls -alh
    pwd
    echo $src
    echo $srcs
    unzip -d /build/src $src 
    runHook postUnpack
  '';

installPhase = ''
    mkdir -p $out
    cp -r /build/src $out/bin
    echo "interpreter func"
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" "$out/bin/func"
    patchelf --set-rpath "${rpath}" "$out/bin/func"
    chmod +x $out/bin/func
    chmod +x $out/bin/gozip
    find $out/bin -type f -name "*.so" -exec patchelf --set-rpath "${rpath}" {} \;
    wrapProgram "$out/bin/func" --prefix LD_LIBRARY_PATH : ${rpath}
  '';
  dontStrip = true;

  meta = {
    homepage = "https://github.com/Azure/azure-functions-core-tools";
    description = "Command line tools for Azure Functions";
    license = stdenv.lib.licenses.mit;
    maintainers = with stdenv.lib.maintainers; [ ];
    platforms = stdenv.lib.platforms.unix;
  };
}
