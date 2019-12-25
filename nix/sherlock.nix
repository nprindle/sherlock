{ enableTor
, stdenv
, lib
, makeWrapper
, fetchFromGitHub
, python37
, tor
}:

let
  sherlockPy = python37.withPackages (ps: with ps; [
    beautifulsoup4
    soupsieve
    certifi
    colorama
    lxml
    requests-futures
    torrequest
  ]);
in stdenv.mkDerivation {
  name = "sherlock";
  src = ../.;
  buildInputs = [ makeWrapper ];
  propagatedBuildInputs = [ sherlockPy ] ++ lib.optional enableTor tor;
  buildPhase = ''
    mkdir -p "$out/lib"
    cp *.json "$out/lib"
    cp *.py "$out/lib"
  '';
  installPhase = ''
    mkdir -p "$out/bin"
    makeWrapper \
      "${sherlockPy}/bin/python3" \
      "$out/bin/sherlock" \
      --argv0 "sherlock" \
      ${lib.optionalString enableTor "--prefix PATH \":\" \"${tor}/bin\""} \
      --add-flags "$out/lib/sherlock.py"
  '';
}
