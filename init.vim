call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-sleuth'
Plug 'lmintmate/blue-mood-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fireplace'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/seoul256.vim'
Plug 'itchyny/lightline.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'NTBBloodbath/rest.nvim' 
Plug 'folke/which-key.nvim'

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

noremap <silent> <leader>a :NERDTreeToggle<CR>
noremap <silent> <leader>q :NERDTreeFind<CR>

noremap <silent> <leader>h :nohl<CR>

nnoremap <C-t>n :tabnew<CR>
nnoremap <C-t>x :tabclose<CR>
nnoremap <C-p>f :Files<CR>
nnoremap <C-p>b :Buffers<CR>

inoremap jk <ESC>

inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

" A shortcut for substitute
noremap ;; :%s:::gc<Left><Left><Left><Left>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup ft_terminal
	autocmd!
	autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

colorscheme seoul256

let g:lightline = {
	\ 'colorscheme': 'seoul256',
	\ }

lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

