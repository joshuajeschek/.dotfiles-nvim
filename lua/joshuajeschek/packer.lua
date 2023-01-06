return require('packer').startup(function()
  use('wbthomason/packer.nvim')
  use('wakatime/vim-wakatime')
  use('jiangmiao/auto-pairs')
  use('notjedi/nvim-rooter.lua')
  use('echasnovski/mini.nvim')
  use('tamton-aquib/duck.nvim')
  use('seandewar/killersheep.nvim')
  use('lambdalisue/suda.vim')

  -- LSP and CMP
  use('mhartington/formatter.nvim')
  use('neovim/nvim-lspconfig')
  use('williamboman/mason.nvim')
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-cmdline')
  use('hrsh7th/nvim-cmp')
  use('onsails/lspkind-nvim')
  use('L3MON4D3/LuaSnip')
  use('rafamadriz/friendly-snippets')
  use('saadparwaiz1/cmp_luasnip')
  use('tzachar/cmp-tabnine', { run = './install.sh', requires = 'hrsh7th/nvim-cmp' })
  use('glepnir/lspsaga.nvim', { branch = 'master' })
  -- language specific
  use('neovimhaskell/haskell-vim')
  use('aklt/plantuml-syntax')
  use('elkowar/yuck.vim')

  -- treesitter
  use('nvim-treesitter/nvim-treesitter')
  use('mrjones2014/nvim-ts-rainbow')

  -- telescope
  use('nvim-telescope/telescope.nvim')
  use('nvim-lua/plenary.nvim')
  use('nvim-telescope/telescope-fzf-native.nvim', {
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  })
  use('nvim-telescope/telescope-file-browser.nvim')
  use('olacin/telescope-cc.nvim')

  -- git
  use('tpope/vim-fugitive')
  use('zivyangll/git-blame.vim')
  use('airblade/vim-gitgutter')

  -- UI
  use('gruvbox-community/gruvbox')
  use('kyazdani42/nvim-web-devicons')
  use('dylanaraps/wal.vim')
  use('lukas-reineke/virt-column.nvim')
  use('vim-airline/vim-airline')
  -- use('fgheng/winbar.nvim')
  -- use('SmiteshP/nvim-gps')
  -- use('glepnir/dashboard-nvim')
end)

