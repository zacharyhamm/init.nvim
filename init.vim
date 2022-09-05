call plug#begin()

"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-sleuth'
Plug 'lmintmate/blue-mood-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fireplace'
"Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/seoul256.vim'
Plug 'itchyny/lightline.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'NTBBloodbath/rest.nvim' 
Plug 'folke/which-key.nvim'
Plug 'neovim/nvim-lspconfig'

Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}

Plug 'mhinz/vim-signify'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

call plug#end()

syntax on
set hidden
set termguicolors
set number
set relativenumber
set showcmd
set nobackup
set tabstop=4
set shiftwidth=4
set cursorline
set mouse=a
set signcolumn=number
set shortmess+=c
set cmdheight=2
set nobackup
set nowritebackup
set encoding=utf-8
set hlsearch
set ignorecase
set incsearch
set so=9999 "keep cursor in the center
set conceallevel=0
set shiftround " rounds to the nearest shiftwidth

noremap <silent> <leader>a :NvimTreeToggle<CR>
noremap <silent> <leader>q :NvimTreeFindFile<CR>

noremap <silent> <leader>h :nohl<CR>

nnoremap <C-t>n :tabnew<CR>
nnoremap <C-t>x :tabclose<CR>
nnoremap <C-p>f :Files<CR>
nnoremap <C-p>b :Buffers<CR>

inoremap jk <ESC>

" A shortcut for substitute
noremap ;; :%s:::gc<Left><Left><Left><Left>

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

augroup ft_terminal
	autocmd!
	autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

colorscheme seoul256

let g:lightline = {
	\ 'colorscheme': 'seoul256',
	\ }

set completeopt=menu,menuone,noselect

lua << EOF
print("🤮")

require("which-key").setup{}
require("nvim-tree").setup{}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
--[[local cmp = require('cmp')

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})--]]

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

--local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
--[[require('lspconfig')['tsserver'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
} --]]
--- using Volar in "takeover" mode
require('lspconfig')['volar'].setup{
    init_options = {
      typescript = {
		serverPath = os.getenv('TSSERVER_PATH')
      }
    },
--    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
    filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
}
require('lspconfig')['rust_analyzer'].setup{
--    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}
EOF

execute "normal! :COQNow"
