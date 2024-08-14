{ lib, clangStdenv, source, gtk4, meson, ninja, pkg-config
, gobject-introspection, vala, gi-docgen }:

clangStdenv.mkDerivation {
  pname = "statusnotifier-systray-gtk4";
  version = "0.1.0"; # Update to the correct version

  src = source;
  nativeBuildInputs = [ meson ninja pkg-config vala gi-docgen ];
  buildInputs = [ gtk4 gobject-introspection ];

  meta = with lib; {
    description =
      "A custom GTK4 widget for representing a system tray, designed for GTK-based desktop panels.";
    homepage = "https://codeberg.org/janetski/statusnotifier-systray-gtk4";
    license = licenses.mit; # Check and update if necessary
    maintainers = with maintainers; [ ];
    platforms = platforms.linux;
  };
}

