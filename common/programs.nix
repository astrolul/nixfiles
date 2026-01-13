{ config, pkgs, inputs, ... }:
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
      vim.theme.name = "onedark";
      vim.theme.style = "darker";
      vim.highlight.Normal.bg = null;
      vim.highlight.Normal.ctermbg = null;
      vim.statusline.lualine.enable = true;
      vim.visuals.nvim-scrollbar.enable = true;
      vim.autocomplete.nvim-cmp.enable = true;
      vim.languages.nix.enable = true;
      vim.languages.clang.enable = true;
      vim.languages.markdown.enable = true;
      vim.languages.python.enable = true;
      vim.lsp.enable = true;
      vim.languages.enableTreesitter = true;
      vim.ui.nvim-highlight-colors.enable = true;
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
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
    theme = "onedark";
    settings = {
      main = {
        font = "FiraCode Nerd Font:size=12";
        pad = "15x15";
      };
      colors = {
        alpha = 0.8;
      };
    };
  };

  programs.nix-ld.enable = true;

  programs.adb.enable = true;
}
