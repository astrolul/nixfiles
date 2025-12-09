{ config, pkgs, inputs, ... }:

{
  home.username = "astrolul";
  home.homeDirectory = "/home/astrolul";
  home.stateVersion = "25.11";

  imports = [ ];

  home.packages = with pkgs; [
    wget
    git
    stow
    flashprog
    pciutils
    ffmpeg
    tree
    fastfetch
    htop
    streamrip
    statix
    xarchiver
    unrar
    inetutils
    nmap
    neovim
  ];  

  programs = {
    bash = {
      enable = true;
    };
    git = {
      enable = true;
      settings = {
        user.name = "astrolul";
        user.email = "85197489+astrolul@users.noreply.github.com";
     };
    };
    fastfetch = {
      enable = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      history.size = 10000;
      initContent = ''
        PS1="%B%F{green}''${''${(%):-%n}:0:1}@''${''${(%):-%m}:0:1}%k %B%F{blue}%1~ %# %b%f%k"

        EDITOR="nvim"
        SUDO_EDITOR="nvim"      

        if [[ $DISPLAY =~ ^:[0-9]+$ ]] && command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
          tmux attach-session -t default || tmux new-session -s default
        fi
      '';
      shellAliases = {
        ls = "ls -la";
        mkdir = "mkdir -p";
        cp = "cp -r";
      };
    };
    tmux = {
      enable = true;
      terminal = "tmux-256color";
      shell = "${pkgs.zsh}/bin/zsh";
      extraConfig = ''
        set-option -sa terminal-overrides ",tmux-256color*:Tc"
        set -g status-style bg=default
        set -g status-fg "#fabd2f"
      '';
    };
  };

}
