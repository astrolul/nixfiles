{ config, pkgs, inputs, ... }:

{
  home.username = "astrolul";
  home.homeDirectory = "/home/astrolul";
  home.stateVersion = "25.05";
  
  home.packages = [
    pkgs.fastfetch
    pkgs.htop
    pkgs.cmus
    pkgs.nerd-fonts.terminess-ttf
    pkgs.brave
    pkgs.flameshot
    pkgs.brightnessctl
  ];  
  
#  programs.home-manager.enable = true;
  
#  imports = [
#      ./suckless.nix
#  ];

  programs.bash = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "astrolul";
    userEmail = "85197489+astrolul@users.noreply.github.com";
  };

  programs.cmus = {
    enable = true;
    theme = "gruvbox";
  };

  programs.fastfetch = {
    enable = true;
  };  

  programs.rofi = {
    enable = true;
    plugins = [pkgs.rofi-emoji];
#    theme = inputs.rofi-merah-custom;
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox_dark_v2";
      theme_background = false;
      truecolor = true;
    };
  };
 
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
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
    };
  };

 programs.tmux = {
  enable = true;
  terminal = "xterm-256color";
  shell = "${pkgs.zsh}/bin/zsh";
  extraConfig = ''
    set-option -sa terminal-overrides ",xterm-256color*:Tc"
    set -g status-style bg=default
    set -g status-fg "#fabd2f"
  '';
 };

  services.dunst.enable = true;

# home.pointerCursor = {
#   enable = true;
#   gtk.enable = true;
#   x11.enable = true;
#   package = pkgs.bibata-cursors;
#   name = "Bibata-Modern-Ice";
#   size = 24;
# };

}
