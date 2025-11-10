{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = [ pkgs.gcc pkgs.gdb pkgs.gnumake pkgs."pkg-config" pkgs.ncurses ];

  shellHook = ''
    clear
    echo "Welcome to your C development environment."
    echo "GCC version: $(gcc --version | head -n1)"
  '';
}
