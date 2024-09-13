{ ... }: {
  nixpkgs.overlays = [
    #    (final: prev: {
    #      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    #        (pyfinal: pyprev: {
    #          numpy = pyprev.numpy.overridePythonAttrs (oldAttrs: {
    #            postPatch = ''
    #              rm numpy/core/tests/test_cython.py
    #              rm numpy/core/tests/test_umath_accuracy.py
    #              rm numpy/core/tests/test_*.py
    #            '';
    #            doCheck = false;
    #            doInstallCheck = false;
    #            dontCheck = true;
    #            disabledTests = [
    #              "test_math"
    #              "test_umath_accuracy"
    #              "test_validate_transcendentals"
    #            ];
    #          });
    #          scipy = pyprev.scipy.overridePythonAttrs (oldAttrs: {
    #            doCheck = false;
    #            doInstallCheck = false;
    #            dontCheck = true;
    #          });
    #          pandas = pyprev.pandas.overridePythonAttrs (oldAttrs: {
    #            doCheck = false;
    #            doInstallCheck = false;
    #            dontCheck = true;
    #          });
    #          eventlet = pyprev.eventlet.overridePythonAttrs (oldAttrs: {
    #            doCheck = false;
    #            doInstallCheck = false;
    #            dontCheck = true;
    #          });
    #          aiohttp = pyprev.aiohttp.overridePythonAttrs (oldAttrs: {
    #            doCheck = false;
    #            doInstallCheck = false;
    #            dontCheck = true;
    #          });
    #          websockets = pyprev.websockets.overridePythonAttrs (oldAttrs: {
    #            doCheck = false; # test hanged
    #            doInstallCheck = false;
    #            dontCheck = true;
    #          });
    #        })
    #      ];
    #    })
  ];
}
