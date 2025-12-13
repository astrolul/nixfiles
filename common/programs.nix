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
      vim.theme.name = "gruvbox";
      vim.theme.style = "dark";
      vim.highlight.Normal.bg = null;
      vim.highlight.Normal.ctermbg = null;
      vim.statusline.lualine.enable = true;
      vim.autocomplete.nvim-cmp.enable = true;
      vim.languages.nix.enable = true;
      vim.languages.clang.enable = true;
      vim.languages.markdown.enable = true;
      vim.languages.python.enable = true;
      vim.lsp.enable = true;
      vim.languages.enableTreesitter = true;
      vim.extraPlugins = {
        vim-css-color = {
          package = pkgs.vimPlugins.vim-css-color;
        };
      };
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.foot = {
    enable = true;
    theme = "gruvbox";
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

}
