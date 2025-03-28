call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/vim-github-dashboard', { 'on': ['GHDashboard', 'GHActivity'] }
Plug 'bling/vim-airline'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'szw/vim-tags'
Plug 'majutsushi/tagbar'
Plug 'terryma/vim-multiple-cursors'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'wsdjeg/vim-fetch'
Plug 'zirrostig/vim-schlepp'
Plug 'zivyangll/git-blame.vim'
Plug 'rhysd/conflict-marker.vim'
call plug#end()

augroup filetypedetect
    au BufRead,BufNewFile ISSUE_EDITMSG setfiletype gitcommit
    au BufRead,BufNewFile PULLREQ_EDITMSG setfiletype gitcommit
augroup END

" Restore cursor position
autocmd BufReadPost *
    \ if index(['gitcommit', 'gitrebase'], &filetype) == -1
    \ && expand('%:t') !~# '^COMMIT_EDITMSG\|MERGE_MSG\|PULLREQ_EDITMSG\|TAG_EDITMSG$'
    \ && expand('%:p:h') !~# '/\.git/'
    \ && expand('%:p') !~# '^/tmp/'
    \ && line("'\"") > 0 && line("'\"") <= line("$")
    \ | exe "normal! g`\""
    \ | endif

set shiftwidth=4
set softtabstop=4
set expandtab
set hlsearch

" Cursor shapes in different modes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Highlight current line
set cursorline
hi CursorLine cterm=NONE ctermbg=234 guibg=#1c1c1c

hi ColorColumn ctermbg=234 guibg=#1c1c1c
let &colorcolumn="81,101,".join(range(121,320),",")

autocmd FileType make setlocal noexpandtab
autocmd FileType gitcommit execute "set colorcolumn=51,".join(range(73,320),',')
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

" Save and restore session (if invoked without arguments).
autocmd VimLeave * nested if bufname('%') !~ 'COMMIT_EDITMSG\|MERGE_MSG\|PULLREQ_EDITMSG\|TAG_EDITMSG' |
    \ execute "mksession! " . $HOME . "/.vim-session" | endif
autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.vim-session") |
    \ execute "source " . $HOME . "/.vim-session" | endif

" Ctrl+\: Toggle NERDTree
map <C-\> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

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

" vim-schlepp
vmap <unique> <C-h> <Plug>SchleppLeft
vmap <unique> <C-j> <Plug>SchleppDown
vmap <unique> <C-k> <Plug>SchleppUp
vmap <unique> <C-l> <Plug>SchleppRight
vmap <unique> <leader>h <Plug>SchleppDupLeft
vmap <unique> <leader>j <Plug>SchleppDupDown
vmap <unique> <leader>k <Plug>SchleppDupUp
vmap <unique> <leader>l <Plug>SchleppDupRight
vmap <unique> i   <Plug>SchleppToggleReindent
nmap <unique> <C-j> <S-v><Plug>SchleppDown<esc>
nmap <unique> <C-k> <S-v><Plug>SchleppUp<esc>

" git-blame
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>
