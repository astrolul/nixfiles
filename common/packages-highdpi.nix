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
    (inputs.st-secondary-src.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: rec {
      configFile = fetchurl {
        url = "https://raw.githubusercontent.com/astrolul/st/secondary/config.h";
        sha256 = "0jmvgfl2siazp16bg6wk42z59k4agzbk1cl9sqmimwcvjdwklq2q";
      };
      postPatch = (oldAttrs.postPatch or "") + '' 
        cp ${configFile} config.h
        sed -i '/CPPFLAGS =/ s/$/ -DFONT_SIZE=25/' config.mk
      '';
    }))

    (inputs.slstatus-src.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: rec {
      configFile = fetchurl {
        url = "https://raw.githubusercontent.com/astrolul/slstatus/main/config.h";
        sha256 = "03r5hqfmbnw4xbwzh9mwfn5vm6dx1hqa1qk012szlxxn0gcznzm8";
      };
      postPatch = (oldAttrs.postPatch or "") + "\n cp ${configFile} config.h";
    }))

    (inputs.dmenu-secondary-src.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: rec {
      configFile = fetchurl {
        url = "https://raw.githubusercontent.com/astrolul/dmenu/secondary/config.h";
        sha256 = "12nkg720fw1npg3z3nbq87znn0mf7x9rcl1r5xsj4sxczwvza70q";
      };
      postPatch = (oldAttrs.postPatch or "") + "\n cp ${configFile} config.h";
    }))

  ];
}
