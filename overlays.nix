{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.neorg-overlay.overlays.default
    (final: prev: {
      intel-vaapi-driver = prev.intel-vaapi-driver.override { enableHybridCodec = true; };
      libreoffice-qt6-fresh = prev.libreoffice-qt6-fresh.overrideAttrs (oldAttrs: {
        doCheck = false;
      });
      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
        (pyfinal: pyprev: {
          websockets = pyprev.websockets.overridePythonAttrs (oldAttrs: {
            postPatch = '''';
            doCheck = false;
            doInstallCheck = false;
            dontCheck = true;
          });

          pyqt5 = pyprev.pyqt5.overridePythonAttrs (oldAttrs: {

            doCheck = false;
            doInstallCheck = false;
            dontCheck = true;
			 });
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
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
    haskellPackages = pkgs.haskellPackages.override {
      overrides = hsSelf: hsSuper: {
        crypton = pkgs.haskell.lib.overrideCabal hsSuper.crypton (oa: {
          doCheck = false;
        });
        tls = pkgs.haskell.lib.overrideCabal hsSuper.tls (oa: {
          doCheck = false;
        });
        crypton-x509-validation = pkgs.haskell.lib.overrideCabal hsSuper.crypton-x509-validation (oa: {
          doCheck = false;
        });
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
