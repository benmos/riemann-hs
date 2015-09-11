{ mkDerivation, stdenv, ghc,
  cereal, data-default, doctest, errors, filepath, HUnit
, lens, network, protobuf, QuickCheck, test-framework
, test-framework-hunit, test-framework-quickcheck2, text, time
, transformers
}:

mkDerivation (
let
  lib         = stdenv.lib;
  isWithin    = p: dirPath: lib.hasPrefix (toString dirPath) (toString p);
  cabalFilter = path: type: (let pathBaseName = baseNameOf path; in
                               !(lib.hasSuffix "~" pathBaseName) &&
                               !(lib.hasSuffix "#" pathBaseName) &&
                               !(lib.hasPrefix "." pathBaseName) &&
                               (
                                   pathBaseName == "riemann.cabal" ||
                                   pathBaseName == "LICENSE"       ||
                                   pathBaseName == "Setup.hs"      ||
                                   isWithin path ./src             ||
                                   isWithin path ./test            ||
                                   false
                               )
                            );
in {
  pname = "riemann";
  version = "0.0.0.1";
  src = builtins.filterSource cabalFilter ./.;
  buildDepends = [
    cereal data-default errors lens network protobuf text time
    transformers
  ];
  testDepends = [
    doctest filepath HUnit QuickCheck test-framework test-framework-hunit
    test-framework-quickcheck2
  ];
  license = stdenv.lib.licenses.mit;
})
