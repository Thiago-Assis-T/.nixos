{ ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
        (pyfinal: pyprev: {
          numpy = pyprev.numpy.overridePythonAttrs (oldAttrs: {
            postPatch = ''
              rm numpy/core/tests/test_cython.py
              rm numpy/core/tests/test_umath_accuracy.py
              rm numpy/core/tests/test_*.py

              patchShebangs numpy/_build_utils/*.py

              substituteInPlace numpy/meson.build \
                --replace 'py.full_path()' "'python'"

              substituteInPlace pyproject.toml \
                --replace-fail "meson-python>=0.15.0,<0.16.0" "meson-python"
            '';
            doCheck = false;
            doInstallCheck = false;
            dontCheck = true;
            disabledTests = [
              "test_math"
              "test_umath_accuracy"
              "test_validate_transcendentals"
            ];
          });
        })
      ];
    })
  ];
  nixpkgs.config.packageOverrides = pkgs: {
    haskellPackages = pkgs.haskellPackages.override {
      overrides = hsSelf: hsSuper: {
        cryptonite = pkgs.haskell.lib.overrideCabal hsSuper.cryptonite (oa: {
          doCheck = false;
        });
        x509-validation = pkgs.haskell.lib.overrideCabal hsSuper.x509-validation (oa: {
          doCheck = false;
        });
      };
    };
  };
}
