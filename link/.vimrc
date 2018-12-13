call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/vim-github-dashboard', { 'on': ['GHDashboard', 'GHActivity'] }
Plug 'bling/vim-airline'
Plug 'valloric/youcompleteme'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'szw/vim-tags'
Plug 'majutsushi/tagbar'
Plug 'terryma/vim-multiple-cursors'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") && &filetype != 'gitcommit' | exe "normal! g'\"" | endif
endif

set shiftwidth=4
set softtabstop=4
set expandtab
set hlsearch

autocmd FileType make setlocal noexpandtab
autocmd FileType gitconfig setlocal noexpandtab shiftwidth=8 softtabstop=8
autocmd FileType bash,sh,zsh setlocal shiftwidth=2 softtabstop=2

" Show trailing whitespace and spaces before a tab
" except on the current line in insert mode
hi ExtraWhitespace ctermbg=red guibg=lightred
match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd BufWinLeave * call clearmatches()

" Ctrl+\: Toggle NERDTree
map <C-\> :NERDTreeToggle<CR>

" F3: Toggle list (display unprintable characters)
hi SpecialKey ctermfg=darkgray guifg=lightgray
hi NonText ctermfg=darkgray guifg=lightgray
set listchars=eol:¬,tab:»­,space:·,extends:>,precedes:<,nbsp:␣
noremap <F3> :set list!<CR>
inoremap <F3> <C-O>:set list!<CR>

" F4: Display line numbers
hi LineNr term=bold cterm=NONE ctermfg=darkgray ctermbg=NONE gui=NONE guifg=darkgray guibg=NONE
set number relativenumber
noremap <F4> :set number! relativenumber!<CR>
inoremap <F4> <C-O>:set number! relativenumber!<CR>
" Disable relative line numbers in insert mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" F7: Format file
map <F7> mzgg=G'z

" F8: Toggle Tagbar
nmap <F8> :TagbarToggle<CR>

" Move lines
noremap <M-Up> :call feedkeys( line('.')==1 ? '' : 'ddkP' )<CR>
noremap <M-Down> ddp

" Duplicate lines
noremap <C-M-Up> yyP
noremap <C-M-Down> yyPj

" Comment lines with Ctrl+/
nmap <C-_> gcc
imap <C-_> <esc>gcci
" xmap <C-_> <Plug>Commentary
