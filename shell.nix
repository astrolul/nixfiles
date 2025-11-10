{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # Packages to include in the shell environment
  buildInputs = with pkgs; [
    gcc       # C compiler
    gdb       # Debugger
    make      # Build tool
    pkg-config # For managing compile/link flags (useful for libraries)
    # Add any C libraries your project needs, e.g.:
    # zlib    # Example: Compression library
    # openssl # Example: Cryptography library
  ];

  # Optional: Set environment variables or shell hooks
  shellHook = ''
    echo "Welcome to your C development environment!"
    echo "GCC version: $(gcc --version | head -n1)"
  '';
}
