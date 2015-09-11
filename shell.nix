let pkgs = import <nixpkgs> {};
    haskellPackages = pkgs.haskellngPackages.override {
      overrides = self: super: {
        riemann          = self.callPackage ./. {};
      };
    };
 in pkgs.lib.overrideDerivation haskellPackages.riemann (attrs: {
   buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })
