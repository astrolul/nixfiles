{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget
    git
    stow
    nerd-fonts.terminess-ttf
    feh
    pavucontrol
    flashprog
    pciutils
    ffmpeg
    tree
    inputs.dmenu-src.packages.${pkgs.system}.default
    inputs.slstatus-src.packages.${pkgs.system}.default
    (inputs.st-src.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: rec {
      configFile = fetchurl {
        url = "https://raw.githubusercontent.com/astrolul/st/main/config.h";
        sha256 = "1gc3d6303fsqjfl67spdqh901qrasaz80pnrhfvq5q16n7k3rsl2";
      };
      postPatch = (oldAttrs.postPatch or "") + "\n cp ${configFile} config.h";
    }))
  ];
}
