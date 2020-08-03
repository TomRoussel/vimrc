let s:pluginrc = expand("<sfile>:p:h") . "/" .  "pluginrc.vim"
if filereadable(s:pluginrc)
    execute 'source' s:pluginrc
endif

""" OPTIONS

""" INDENTATION OPTIONS
set tabstop=4
set softtabstop=4 
set autoindent
set shiftwidth=0
set expandtab


""" MISC. SETTINGS  
set shell=zsh
set incsearch
set hlsearch
set laststatus=2
set nocompatible
set smartcase
set smarttab
set ignorecase " This needs to be set for smartcase to have any effect
set backspace=indent,eol,start " Otherwise backspace acts weirdly
set dir=~/.vim/swap
set backupdir=~/.vim/backup
set undodir=~/.vim/undo
set undofile " This makes sure you actually create undofile
set spelllang=en
set wildmenu
set scrolloff=3

let g:dispatch_no_maps = 1

filetype plugin on

syntax enable

let mapleader=','

""" VISUAL STUFF

colorscheme gruvbox
set background=dark
" hi Normal guibg=NONE ctermbg=NONE

set fillchars=vert:│

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }


""" CUSTOM COMMANDS
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis
command SaveSession mksession! ~/.vim_default_session
command ClearSpaces %s/^ \{1,\}$//
command ThisDir lcd %:p:h
command Dutch set spell | set spelllang=nl
command English set spell | set spelllang=en
" command -range DebugPrint <line1>,<line2>s/print/logging.debug
command -range DebugPrint <line1>,<line2>call DebugPrintF()

function DebugPrintF() range
    execute a:firstline . "," a:lastline . "s/print/logging.debug"

    let search_result = search("import logging", "wn")
    if !search_result
        echohl Warningmsg
        echom "Warning: not importing logging"
        echohl none
    endif
endfunction

" Vim - fugitive commands
command Gs Gstatus
command Gc Gcommit

" Ack dependant commands
command Todo Ack TODO
command TODO Ack TODO

" pandoc dependant commands
command! -range MD <line1>,<line2>!pandoc -f markdown -t latex


""" PLUGIN SETTINGS
let g:NERDTreeWinPos = "right"

" ctrlp plugin won't search for a top directory (with .git), it will just search the cwd
let g:ctrlp_working_path_mode = 'a'

" python-syntax options, setting all highlight options on
let python_highlight_all = 1

" vim-test
let test#strategy = "vimterminal"
nnoremap <F5> :TestSuite<CR>
nnoremap <F6> :TestLast<CR>
nnoremap <F7> :TestFile<CR>

let g:ale_linters = {
\   "python": ['flake8']
\}

let g:ale_fixers = {
\   "python": ["black"]
\}

""" UNMAPPING SOME STUFF
" Ignore ZZ and ZQ (dangerous commands)
nnoremap ZZ zz 
nnoremap ZQ zz

" Unmap keybind to open new window
nnoremap <C-w>n <NOP>
tnoremap <C-w>n <C-w>N

""" REMAPPINGS

nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

nnoremap <leader>s :w<CR>
nnoremap <leader>e :e ~/.vim/customrc.vim<CR>
nnoremap <leader>m :Make<CR>

nnoremap <C-f> :CtrlP<CR>
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <F4> <C-w>h:q<CR>:diffoff<CR>
nnoremap <leader>p :CtrlPTag<CR>

nnoremap <C-n> :nohl<CR>
" This overrides a tag mapping (I never use tags anyways)
nnoremap <C-t> :tabnew<CR>

" Don't open help when pressing F1
nnoremap <F1> <NOP>
inoremap <F1> <ESC>

" Replace the incorrect spelling with the first suggestion
nnoremap <leader>z 1zs 

" Shortcut to go to the next tab
nnoremap <c-g> gt
tnoremap <c-g> <c-w>gt

vnoremap $1 <ESC>`<i(<ESC>`>la)<ESC>
vnoremap $2 <ESC>`<i{<ESC>`>la}<ESC>
vnoremap $3 <ESC>`<i[<ESC>`>la]<ESC>
vnoremap $4 <ESC>`<i"<ESC>`>la"<ESC>

" Remap Y to copy selection to main clipboard
vnoremap Y "+y

" inoremap ( ()<ESC>i
" inoremap [ []<ESC>i
" inoremap { {}<ESC>i

""" SIMPLE AUTOCOMMANDS
augroup vimfiles
    autocmd!
    autocmd BufWritePost .vimrc nested source %
    autocmd BufWritePost ~/.vim/customrc.vim nested source %
    autocmd BufRead ~/.vim/customrc.vim :set syntax=vim
augroup end
" autocmd ColorScheme * hi Normal guibg=NONE ctermbg=NONE

""" AUTOGROUP FOR FILETYPES
augroup python 
	autocmd!
	autocmd Filetype python syn keyword pythonBuiltin self
    autocmd Filetype python nnoremap th oimport ipdb; ipdb.set_trace()<ESC>
    autocmd Filetype python set foldmethod=indent
    autocmd Filetype python set foldlevel=20
augroup end

augroup cpp
    autocmd!
    autocmd Filetype cpp set foldmethod=syntax
    autocmd Filetype cpp set foldlevel=20
    autocmd Filetype cpp inoreabbr <buffer> forr for(int idx=0; idx < <ESC>mai; idx++)<ESC>`ai
augroup end

augroup pandoc
    autocmd! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup end

""" ABBREVIATIONS
abbr teh the
abbr wrt w.r.t.

let s:localrc = expand("<sfile>:p:h") . "/localrc.vim"
if filereadable(s:localrc)
    execute 'source' s:localrc
endif


