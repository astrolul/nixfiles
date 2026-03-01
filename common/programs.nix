{
  config,
  pkgs,
  inputs,
  ...
}:
{

  programs.dconf.enable = true;

  programs.virt-manager.enable = true;

  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings = {
      vim.vimAlias = true;
      vim.viAlias = true;
      vim.theme.enable = true;
      vim.theme.name = "gruvbox";
      vim.theme.style = "dark";
      vim.dashboard.alpha.enable = true;
      vim.highlight.Normal.bg = null;
      vim.highlight.Normal.ctermbg = null;
      vim.statusline.lualine.enable = true;
      vim.visuals.nvim-scrollbar.enable = true;
      vim.autocomplete.nvim-cmp.enable = true;
      vim.languages.nix = {
        enable = true;
        format = {
          enable = true;
          type = [
            "nixfmt"
          ];
        };
      };
      vim.languages.clang.enable = true;
      vim.languages.markdown.enable = true;
      vim.languages.python.enable = true;
      vim.lsp.enable = true;
      vim.languages.enableTreesitter = true;
      vim.ui.nvim-highlight-colors.enable = true;
    };
  };

  programs.sway = {
    enable = true;
  };

  programs.light = {
    enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "FiraCode Nerd Font:size=12";
        pad = "15x15";
      };
      
      colors = {
        alpha = 1.0;

        # Special colours
        foreground = "c5c8c6";
        background = "1d1f21";
        cursor = "c5c8c6";

        # Normal colours (0-7)
        regular0 = "1d1f21";   # black
        regular1 = "cc342b";   # red
        regular2 = "198844";   # green
        regular3 = "fba922";   # yellow
        regular4 = "3971ed";   # blue
        regular5 = "a36ac7";   # magenta
        regular6 = "3971ed";   # cyan (same as blue in this scheme)
        regular7 = "c5c8c6";   # white

        # Bright colours (8-15)
        bright0 = "969896";    # bright black
        bright1 = "cc342b";    # bright red
        bright2 = "198844";    # bright green
        bright3 = "fba922";    # bright yellow
        bright4 = "3971ed";    # bright blue
        bright5 = "a36ac7";    # bright magenta
        bright6 = "3971ed";    # bright cyan
        bright7 = "ffffff";    # bright white
      };
    };
  };

  programs.nix-ld.enable = true;

  programs.adb.enable = true;
}
