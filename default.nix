{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  fetchurl
}:

stdenv.mkDerivation rec {
  name = "pview-${version}";
  version = "1.1";

  src = fetchurl {
    url = "https://github.com/deepsea-inria/pview/archive/${version}.tar.gz";
    sha256 = "16ca288f10101a7480112dc17f5526628a815509e1167fe70c760a03b24ffb16";
  };

  buildInputs = with pkgs; [ ocaml ];  

  installPhase = ''
    mkdir -p $out/bin/
    cp pview $out/bin/
    mkdir -p $out/doc/
    cp README.md $out/doc/
  '';

  meta = {
    description = "A tool to generate a utilization plot from the logging data of the run of a parallel program.";
    homepage = http://deepsea.inria.fr/;
  };
}