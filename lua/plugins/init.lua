return {
  'wakatime/vim-wakatime',
  'jiangmiao/auto-pairs',
  -- 'notjedi/nvim-rooter.lua',
  'ahmedkhalf/project.nvim',
  'echasnovski/mini.nvim',
  'gpanders/editorconfig.nvim',

  'github/copilot.vim',

  -- LSP and CMP
  'mhartington/formatter.nvim',
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'onsails/lspkind-nvim',
  { 'L3MON4D3/LuaSnip',
    build = 'make install_jsregexp',
    dependencies = {'rafamadriz/friendly-snippets'}
  },
  'saadparwaiz1/cmp_luasnip',
  'nvimdev/lspsaga.nvim',
  -- language specifi,
  'neovimhaskell/haskell-vim',
  'aklt/plantuml-syntax',
  'elkowar/yuck.vim',
  'prisma/vim-prisma',
  'imsnif/kdl.vim',
  { 'kaarmu/typst.vim',
    ft = 'typst',
    lazy=false
  },

  -- treesitter
  'nvim-treesitter/nvim-treesitter',
  'mrjones2014/nvim-ts-rainbow',

  -- telescope
  'nvim-telescope/telescope.nvim',
  'nvim-lua/plenary.nvim',
  { 'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  'nvim-telescope/telescope-file-browser.nvim',
  'olacin/telescope-cc.nvim',
  'sopa0/telescope-makefile',
  'akinsho/toggleterm.nvim',

  -- git
  'tpope/vim-fugitive',
  'zivyangll/git-blame.vim',
  'airblade/vim-gitgutter',

  -- UI
  'gruvbox-community/gruvbox',
  'kyazdani42/nvim-web-devicons',
  'dylanaraps/wal.vim',
  'lukas-reineke/virt-column.nvim',
  'vim-airline/vim-airline',
  'rcarriga/nvim-notify',
  { 'andrewferrier/wrapping.nvim',
    config = function()
      require('wrapping').setup({
        notify_on_switch = false,
        softener = { tex = true, markdown = true, typst = true }
      })
    end
  },
  -- 'SmiteshP/nvim-gps',

  -- 'kenn7/vim-arsync',
}
