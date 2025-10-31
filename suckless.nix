{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    inputs.st-src.packages.${pkgs.system}.default
    inputs.dmenu-src.packages.${pkgs.system}.default
    inputs.slstatus-src.packages.${pkgs.system}.default
  ];
}
