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
set mouse=a
set foldlevelstart=20

let g:dispatch_no_maps = 1
let g:tex_flavor = "latex"

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

command OpenFile Dispatch! xdg-open %

" Zotero outputs bibtex on a single line, this command makes it prettier
command BibtexMultiline silent s/}$/\r}/ | silent -1 | silent s/, \(\w\+=\)/,\r  \1/g

" Vim - fugitive commands
command Gs Git
command Gc Git commit

" Ack dependant commands
command Todo Ack TODO
command TODO Ack TODO

" pandoc dependant commands
command! -range MD <line1>,<line2>!pandoc -f markdown -t latex
command Today read !date +\%Y-\%m-\%d



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

let g:EasyMotion_smartcase = 1

map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
nmap <leader>f <Plug>(easymotion-overwin-f)


" fzf commands
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat --color=always {}', '--height=30%']}, <bang>0)


" Vimwiki settings
let g:vimwiki_folding="expr"
let g:vimwiki_table_mappings=0
let g:vimwiki_table_auto_fmt=0

" Snipmate settings
let g:snipMate = { 'snippet_version' : 1}
imap <C-J> <PLUG>snipMateNextOrTrigger

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
nnoremap <leader><leader>m :w<CR>:Make!<CR>

" nnoremap <C-f> :CtrlP<CR>
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <F4> <C-w>h:q<CR>:diffoff<CR>
" nnoremap <leader>p :CtrlPTag<CR>

" remappings for fzf
nnoremap <C-p> :Files<CR>
" <C-_> maps to <C-/>
nnoremap <C-_> :Lines<CR> 

" Goyo shortcut
nnoremap <leader>g :Goyo<CR>

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

" vnoremap $1 <ESC>`<i(<ESC>`>la)<ESC>
" vnoremap $2 <ESC>`<i{<ESC>`>la}<ESC>
" vnoremap $3 <ESC>`<i[<ESC>`>la]<ESC>
" vnoremap $4 <ESC>`<i"<ESC>`>la"<ESC>

" Remap Y to copy selection to main clipboard
vnoremap Y "+y
" Search for the highlighted text
vnoremap <C-_> y/<C-R>"<CR> 

nnoremap <leader>o :OpenFile<CR>

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

augroup tex
    autocmd!
    autocmd Filetype tex set linebreak
    autocmd Filetype tex set spell | set spelllang=en
augroup end

augroup pandoc
    autocmd! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup end

augroup vimwiki
    autocmd!
    autocmd BufRead *.wiki setlocal linebreak
augroup end

""" ABBREVIATIONS
abbr teh the
abbr wrt w.r.t.

let s:shorthand = expand("<sfile>:p:h") . "/" . "shorthand.vim"
command SH execute 'source' s:shorthand

execute "nnoremap <leader>h :vs" s:shorthand "<CR>"

function Showsh()
    vnew
    " vertical resize 40
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal nobuflisted

    execute 'read' s:shorthand
    0delete
    silent %s/iabbr <buffer> //
    silent %s/ / - /

    " Resize buffer to the max linelength
    silent %yank g
    silent %!wc -L
    silent delete h
    silent put g
    execute "vertical resize" @h

    0d

    setlocal nomodifiable
    wincmd p
endfunction

command ShowSH call Showsh()

let s:localrc = expand("<sfile>:p:h") . "/" . "localrc.vim"
if filereadable(s:localrc)
    execute 'source' s:localrc
endif


