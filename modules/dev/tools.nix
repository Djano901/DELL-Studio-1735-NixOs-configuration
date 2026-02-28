{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # 1. Installation des plugins via Nix (plus simple que de gérer un plugin manager interne)
    plugins = with pkgs.vimPlugins; [
      nvim-tree-lua        # Un explorateur de fichiers sur le côté (comme dans Micro/VS Code)
      lualine-nvim         # Une belle barre de statut en bas
      nvim-treesitter.withAllGrammars # Coloration syntaxique ultra-avancée
      catppuccin-nvim      # Un thème de couleurs magnifique
      yazi-nvim
    ];

    # 2. Ta configuration Lua
    extraLuaConfig = ''
      -- Thème
      vim.cmd.colorscheme "catppuccin"

      -- Options de base
      vim.opt.number = true         -- Numéros de ligne
      vim.opt.relativenumber = true -- Numéros relatifs
      vim.opt.mouse = 'a'           -- Activer la souris
      vim.opt.cursorline = true     -- Surligner la ligne actuelle
      
      -- Configuration de la barre du bas (Lualine)
      require('lualine').setup()

      -- Raccourcis clavier (Keymaps)
      -- 'leader' est la touche principale pour tes raccourcis, souvent l'Espace
      vim.g.mapleader = " "
      
      -- Ouvrir l'explorateur de fichiers avec 'Espace + e'
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
      
      -- Sauvegarder avec 'Ctrl + s' (comme dans Micro !)
      vim.keymap.set({'n', 'i', 'v'}, '<C-s>', '<cmd>w<cr><esc>')

      -- Raccourci pour ouvrir Yazi dans Neovim
      -- On utilise 'Espace + y'
      vim.g.mapleader = " "
      vim.keymap.set('n', '<leader>y', function()
        require('yazi').yazi()
      end, { desc = "Ouvrir Yazi" })
    '';
  };
}
