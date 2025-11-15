{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = [ pkgs.gcc pkgs.gdb pkgs.gnumake pkgs."pkg-config" pkgs.ncurses pkgs.xorg.libX11 pkgs.xorg.libXft pkgs.xorg.libXinerama pkgs.flex pkgs.bison ];

  shellHook = ''
    clear
    echo "🚀 Welcome to your C development environment."
    echo "GCC version: $(gcc --version | head -n1)"
  '';
}
