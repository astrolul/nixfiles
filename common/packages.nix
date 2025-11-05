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
    inputs.dmenu-src.packages.${pkgs.system}.default
    inputs.slstatus-src.packages.${pkgs.system}.default
    (inputs.st-src.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: rec {
      configFile = fetchurl {
        url = "https://raw.githubusercontent.com/astrolul/st/main/config.h";
        sha256 = "1cx96pq7sgs3i2zpgln0zwlbqnsndvv61l788dlbas2pc6wwy9y9";
      };
      postPatch = (oldAttrs.postPatch or "") + "\n cp ${configFile} config.h";
    }))
  ];
}
