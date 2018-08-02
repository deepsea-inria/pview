{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  buildDocs ? false
}:

stdenv.mkDerivation rec {
  name = "pview";

  src = pkgs.fetchFromGitHub {
    owner  = "deepsea-inria";
    repo   = "pview";
    rev    = "50843802393190055bebed9bc0960861d635201e";
    sha256 = "0n36nyfix3an84i1f08iby03zjb6jai8rjr42pxbr2yzl2q9r9vq";
  };

  buildInputs =
    let
      p = [ pkgs.ocaml ];
      ext = [ pkgs.pandoc pkgs.texlive.combined.scheme-medium ];
    in
    if buildDocs then p ++ ext else p;

  buildPhase =
    if buildDocs then ''
      make pview doc
    ''
    else ''
      make pview
    '';

  installPhase = ''
    mkdir -p $out/bin/
    cp pview $out/bin/
    mkdir -p $out/doc/
    cp README.* $out/doc/
  '';

  meta = {
    description = "A tool to generate a utilization plot from the logging data of the run of a parallel program.";
    license = "MIT";
    homepage = http://deepsea.inria.fr/;
  };
}
