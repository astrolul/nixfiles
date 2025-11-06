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
    inputs.slstatus-src.packages.${pkgs.system}.default
    (inputs.st-src.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: rec {
      configFile = fetchurl {
        url = "https://raw.githubusercontent.com/astrolul/st/main/config.h";
        sha256 = "1cx96pq7sgs3i2zpgln0zwlbqnsndvv61l788dlbas2pc6wwy9y9";
      };
      postPatch = (oldAttrs.postPatch or "") + "\n cp ${configFile} config.h";
    }))

    (inputs.dmenu-secondary-src.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: rec {
      configFile = fetchurl {
        url = "https://raw.githubusercontent.com/astrolul/dmenu/secondary/config.h";
        sha256 = "1cf4wlwy2pr0klsrq5bsh8kwajnsppax5c93wr8a8yqwn85xmnvp";
      };
      postPatch = (oldAttrs.postPatch or "") + "\n cp ${configFile} config.h";
    }))

  ];
}
