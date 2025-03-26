{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  dbus,
  libxkbcommon,
  seatd,
  udev,
  stdenv,
  wayland,
  libinput,
  libgbm,
}:

rustPlatform.buildRustPackage rec {
  pname = "catacomb";
  version = "944401af28057eabdbec2f4f93951676284a0a";

  src = fetchFromGitHub {
    owner = "catacombing";
    repo = "catacomb";
    rev = "commit-db${version}";
    hash = "sha256-GniiA5U0GI1Kt4SN/DALBFGqKN/0vsx1zZ+OfwgBe/4=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "smithay-0.3.0" = "sha256-wBuW12+F8itb7TkXn+pW+D1BustFtYtwYnwrcecurww=";
      "wayland-backend-0.1.0-beta.8" = "sha256-7UCzvxLt9fYxrCAovkinxPjlTU2mjfk4ICDerqJB+Dc=";
    };
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    dbus
    libxkbcommon
    seatd
    udev
    libinput
    libgbm
  ] ++ lib.optionals stdenv.isLinux [
    wayland
  ];

  meta = {
    description = "A Wayland Mobile Compositor";
    homepage = "https://github.com/catacombing/catacomb#";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "catacomb";
  };
}
