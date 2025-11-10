{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = [ pkgs.gcc pkgs.gdb pkgs.make pkgs.pkg-config ];

  shellHook = ''
    echo "Welcome to your C development environment."
    echo "GCC version: $(gcc --version | head -n1)"
  '';
}
