{ pkgs, ... }:
{
  users.users.astrolul = {
    isNormalUser = true;
    description = "astrolul";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  environment.variables = {
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
  };

  programs.zsh.enable = true;
}
