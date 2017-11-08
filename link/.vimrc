syntax on
filetype indent plugin on
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") && &filetype != 'gitcommit' | exe "normal! g'\"" | endif
endif

set ruler

" Indentation
set shiftwidth=4
set softtabstop=4
set autoindent
set expandtab
autocmd FileType make setlocal noexpandtab

" F3: Toggle list (display unprintable characters).
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

" Show trailing whitespace and spaces before a tab
" except on the current line in insert mode
hi ExtraWhitespace ctermbg=red guibg=lightred
match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd BufWinLeave * call clearmatches()

" Search highlight
set hlsearch
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Move lines
noremap <M-Up> :call feedkeys( line('.')==1 ? '' : 'ddkP' )<CR>
noremap <M-Down> ddp

" Duplicate lines
noremap <C-M-Up> yyP
noremap <C-M-Down> yyPj
