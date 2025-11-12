{ config, pkgs, inputs, ... }:
{
 
  programs.dconf.enable = true;
  
  programs.virt-manager.enable = true;

  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings = {
      vim.theme.enable = true;
      vim.theme.name = "gruvbox";
      vim.theme.style = "dark";
      vim.highlight.Normal.bg = null;
      vim.highlight.Normal.ctermbg = null;
      vim.statusline.lualine.enable = true;
      vim.autocomplete.nvim-cmp.enable = true;
      vim.languages.nix.enable = true;
      vim.languages.markdown.enable = true;
      vim.lsp.enable = true;
      vim.languages.enableTreesitter = true;
      vim.extraPlugins = {
        vim-css-color = {
          package = pkgs.vimPlugins.vim-css-color;
        };
      };
    };
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    xorg.libX11
    xorg.libXft
    xorg.libXinerama
    imlib2
    freetype
    harfbuzz
    fontconfig
  ];

}
