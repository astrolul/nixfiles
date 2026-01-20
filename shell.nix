{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  packages = [
    pkgs.gcc
    pkgs.gdb
    pkgs.gnumake
    pkgs."pkg-config"
    pkgs.ncurses
    pkgs.xorg.libX11
    pkgs.xorg.libXft
    pkgs.xorg.libXinerama
    pkgs.flex
    pkgs.bison
    pkgs.python3
    pkgs.python313Packages.pygame
    pkgs.python313Packages.discordpy
    pkgs.sdl3
    pkgs.rustc
    pkgs.cargo
  ];

  shellHook = ''
    clear
    echo "🚀 Welcome to your C development environment."
    echo "GCC version: $(gcc --version | head -n1)"
    echo "Python version: $(python3 --version)"
  '';
}
