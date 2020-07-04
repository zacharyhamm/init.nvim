" Plugins - you'll need junegunn/vim-plug in autoload
call plug#begin()
Plug 'godlygeek/tabular'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'racer-rust/vim-racer'
Plug 'mustache/vim-mustache-handlebars'
Plug 'scrooloose/nerdtree'
Plug 'freeo/vim-kalisi'
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'morhetz/gruvbox'
Plug 'vim-scripts/summerfruit256.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'vim-scripts/gtags.vim'
Plug 'Yggdroot/indentline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'vim-vdebug/vdebug'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-obsession'

"Plug 'Shougo/vimproc.vim', { 'do': 'make' }
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'Shougo/neco-vim'
"Plug 'zchee/deoplete-jedi'
"Plug 'zchee/deoplete-go', { 'do': 'make' }
"Plug 'rip-rip/clang_complete'
"Plug 'phpvim/phpcd.vim', { 'for': 'php', 'do': 'composer update' }
"Plug 'ozelentok/deoplete-gtags'
"Plug 'fatih/vim-go'
"Plug 'garyburd/go-explorer'
"Plug 'posva/vim-vue'
"Plug 'airblade/vim-gitgutter'
"Plug '~/Code/deoplete-php'

call plug#end()

set termguicolors

if has('mouse')
	set mouse=a
endif

set background=dark
colorscheme solarized 

if has('mac')
	set directory=~/.vimswap/
	let node14path = "/Users/zachary/.nvm/versions/node/v14.3.0/bin/node"
	let g:clang_library_path="/Library/Developer/CommandLineTools/usr/lib/libclang.dylib"
	if filereadable(node14path)
		let g:coc_node_path=node14path
	endif
endif

" Deoplete --- we're on coc.nvim now
"let g:deoplete#enable_at_startup = 0
"let g:deoplete#sources#go#gocode_binary = '/home/zsh/Hacking/gocode/bin/gocode'
"let g:deoplete#auto_complete_delay = 50

let g:vim_json_conceal=0
let g:rustfmt_autosave = 1
let g:indentLine_char = "|"
let g:netrw_liststyle=3

set hidden
set number
set relativenumber
set showcmd
set noexpandtab
set tabstop=4
set shiftwidth=4
set shiftround " rounds to the nearest shiftwidth
set autoindent
"set signcolumn
set updatetime=300
set cmdheight=2
set nobackup
set nowritebackup

let g:lightline = {
	\ 'colorscheme': 'solarized',
	\ }

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nnoremap <C-t>n :tabnew<CR>
nnoremap <C-t>x :tabclose<CR>
noremap <silent> <leader>a :NERDTreeToggle<CR>

" Resync syntax highlighting 
noremap <silent> <leader>s :syntax sync fromstart<CR> 

" Mappings for fzf
nnoremap <C-p>f :Files<CR>
nnoremap <C-p>b :Buffers<CR>

" Trim whitespace
command! TrimSpaces execute "silent! normal! mq:%s:\\v\\s+$::g\<CR>`q"

" A shortcut for substitute
noremap ;; :%s:::gc<Left><Left><Left><Left>

" vim-racer
let g:racer_cmd = '~/.cargo/bin/racer'

augroup buftype_term
	autocmd!
	autocmd TermOpen * setlocal nonumber
	autocmd TermOpen * setlocal norelativenumber
augroup END

let g:vdebug_options={
	\"port" : 9001,
	\ }

" Vim filetype settings {{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim :setlocal foldmethod=marker
augroup END
" }}}

" PHP filetype customizations {{{
augroup filetype_php
	autocmd!
	function! PHPAutoCommands()
		"    setlocal omnifunc=phpcd#CompletePHP
		iabbrev <buffer> pubfnc public function
		iabbrev <buffer> privfnc private function
		iabbrev <buffer> protfnc protected function
		iabbrev <buffer> pubstfnc public static function
		iabbrev <buffer> privstfnc private static function
		iabbrev <buffer> protstfnc protected static function
		nnoremap <buffer> <Leader>l :!php -l %<CR>
	endfunction
	autocmd FileType php :call PHPAutoCommands()
	""    autocmd BufWritePre *.php :TrimSpaces
augroup END
" }}}

" C filetype {{{
augroup filtype_c
	autocmd!
	function! CeeAutoCommands()
		setlocal foldmethod=marker " for php-src
		autocmd BufWritePre *.c :TrimSpaces
		autocmd BufWritePre *.h :TrimSpaces
	endfunction
	autocmd FileType c :call CeeAutoCommands()
augroup END
" }}}

nnoremap <leader>ev :split $MYVIMRC<cr>

" Wrap word in quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel 


echom "😻 benvenuto"
