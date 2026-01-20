{ pkgs, ... }:
{
  users.users.astrolul = {
    isNormalUser = true;
    description = "astrolul";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "adbusers"
    ];
    packages = with pkgs; [ ];
  };

  users.users.astrolul.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILJqpwrawF97qG9k5Ss28crZEqUcOGz1mrsncycByksb astrolul" # content of authorized_keys file
    # note: ssh-copy-id will add user@your-machine after the public key
    # but we can remove the "@your-machine" part
  ];

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  environment.variables = {
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
  };

  programs.zsh.enable = true;
}
