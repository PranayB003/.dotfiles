"  Appearance.
"  Put a   message in the last line of the window to see which
"  mode (Insert,"  Replace, Visual) you are in.
set showmode

"  Show the line number
set number
"  and column number of the cursor position.
set ruler

"  Always show status line.
set laststatus=2

" Modify status line
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)

"  Show partial commands in    the last line of the screen.
set showcmd

"  Tell to vim which color the background looks like, so it   can adjust the
"   syntax highlighting. If   your terminal is    using a white on black scheme you
"   can use 'set background=dark'.
set background=dark

"  Turn on syntax highlighting.
syntax on
syntax enable

"  Editing.
"  Number of spaces that a   <Tab> in    the file counts for. Setting
"  'tabstop' to"  any other value than 8   can make your file appear wrong
"  when printing it. For"  solving this isssue :set tabstop=8.
set tabstop=2

"  Number of spaces to use for each step of (auto) indent.
set shiftwidth=2
set expandtab

"  Use the appropriate number of spaces to insert a   <Tab>.
set expandtab

"  Allow backspacing over autoindent, line breaks and start of insert
"  action.
set backspace=indent,eol,start

"  Automatic identation.
set autoindent 
set smartindent
set cindent

"  Load the indent file for specific file types.
filetype indent on

"  When indenting in    visual mode, don't lose the selection."  Shift
"  lines right/left and start visual mode with the same mode and the same"
"  area as the previous selection.
vnoremap > ><CR>gv
vnoremap < <<CR>gv

"  Map  'Alt -  Insert' to paste text (from selection register) in Paste Mode"
"  Notes: <C-R><C-O>* means insert literally the text from register 
inoremap <M-Insert> <Esc>:set paste<CR>i<C-R><C-O>*<Esc>:set nopaste<CR>i

"  Clipboard."  Was vim compiled with clipboard support?
"if has('clipboard')
	" Use * register (selection register) for operations which would normally
	" go to the " register (unnamed register), example: yank, delete,change, etc.
  "	set clipboard=unnamed
"else
"	echo "Vim compiled without clipboard option."
"endif

"  Search."
"  Search case-sensitive only if there is    a capital letter in    the search
"  expression, otherwise ignore case.
set ignorecase
set smartcase

"  While typing a search command, show where the pattern matches.
set incsearch

"  By default highlight matches when searching.
set hlsearch

"  Use <CR> in  normal mode to clear the search pattern.
nnoremap <CR> :let @/ = ""<CR>:echo "search pattern cleared"<CR>

"  Enable file type detection.
filetype on

"  Load the indent file for specific file types.
filetype indent on
"  Plugins"

" Load plugin files for specific file types.
filetype plugin on

" Editing to 79 columns.
set textwidth=79

" Highlight columns that go over the 79 column.
"highlight OverLength term=reverse cterm=reverse ctermfg=1 guifg=White guibg=Red
"match OverLength /\%80v.\+/

" Highlight column 80 in grey
set colorcolumn=80                                                      
highlight ColorColumn ctermbg=8 guibg=white

" highlight current line
if exists("&cursorline")
  "set cursorline
  "hi CursorLine term=underline,bold cterm=underline,bold
endif

" yank and paste from system clipboard
noremap gp "*p
noremap gy "*y

" set color scheme
try
  color github_dark_dimmed
catch
  color slate
endtry
