
" NeoVim 'vimrc' of aika

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" https://github.com/junegunn/vim-plug#neovim
call plug#begin('~/.local/share/nvim/plugged')

" Arduino IDE vim plugin
Plug 'stevearc/vim-arduino'

" CtrlP fuzzy finder
" https://github.com/ctrlpvim/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'

" to deal with trailing whitespace
" https://github.com/ntpeters/vim-better-whitespace
Plug 'ntpeters/vim-better-whitespace'

" autocompletion
" https://github.com/ncm2/ncm2
" all syntaxes: https://github.com/ncm2/ncm2/wiki

" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-path'
" Plug 'ncm2/ncm2-tern',  {'do': 'npm install'}
" Plug 'ncm2/ncm2-cssomni'
" Plug 'ncm2/ncm2-racer'

" True snippet and additional text editing support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'

" File Explorer
Plug 'preservim/nerdtree'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

" expanding autocompletion
" https://github.com/ncm2/ncm2-snipmate

" Plug 'ncm2/ncm2-snipmate'
Plug 'tomtom/tlib_vim'
Plug 'marcweber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'

" bottom bar
" https://github.com/vim-airline/vim-airline

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" gruvbox theme
Plug 'morhetz/gruvbox'

" codeschool theme
Plug 'antlypls/vim-colors-codeschool'

" light theme
Plug 'ayu-theme/ayu-vim'

" gcc for one line; gc for multiple
Plug 'tpope/vim-commentary'

" JSX syntax highlighting
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

"Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins'}
" currently broken

" Delete a buffer without changing the layout
Plug 'qpkorr/vim-bufkill'

call plug#end()
filetype on
set relativenumber

" expand completion on <Return>
" inoremap <silent> <expr> <CR> ncm2_snipmate#expand_or("\<CR>", 'n')

" scrolling thru autocompletion menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" enable autocompletion for all buffers
" autocmd BufEnter * call ncm2#enable_for_buffer()
set shortmess+=c
set completeopt=noinsert,menuone,noselect

inoremap <c-c> <ESC>

let mapleader="\<SPACE>"
syntax on
set nu
set smartindent
set formatoptions-=o " don't continue comments on newlines
set termguicolors
set nojoinspaces " prevent two spaces in a row
set splitbelow splitright " normal splits ffs
set nostartofline " don't jump to first char of the line
set hidden nobackup nowritebackup
set cmdheight=2 " more space for messages
set updatetime=300

command! Q q " map that annoying shift Q to normal q

" buffer navigation
nnoremap <Leader>k :bnext!<CR>
nnoremap <Leader>j :bprevious!<CR>
nnoremap <Leader>l :CtrlPBuffer<CR>
" use bufkill for buffer deletion
nnoremap <Leader>q :BD<CR>
nnoremap <Leader>Q :bdelete!<CR>

" focus nerdtree
nnoremap <Leader>t :NERDTreeFocus<CR>

" yank to system clipboard
vnoremap <Leader>y "*y

" placeholder replacer stolen from Luke Smith
" https://www.youtube.com/watch?v=cTBgtN-s2Zw
vnoremap <Leader><Tab> <Esc>/<++><CR>"_c4l
map <Leader><Tab> <Esc>/<++><CR>"_c4l

" clear last search pattern
map <Leader>/ :let @/ = ""<CR>

" trailing whitespace highlighting
highlight ExtraWhitespace ctermbg=white
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
let g:strip_whitelines_at_eof=1 " strip blank lines at <eof>
let g:better_whitespace_skip_empty_lines=1

" autoreload at save
" neovim vimrc
autocmd BufWritePost init.vim silent so %
" Xresources etc
autocmd BufWritePost ~/.Xresources,~/.Xdefaults silent !xrdb %

" unmapping it because i've learnt that is very useful!!!
" when you use `f` (find) it jumps to the next find (`;`)
" nnoremap ; :
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" alduin colorscheme
" https://github.com/AlessandroYorba/Alduin

"let g:alduin_Shout_Become_Ethereal = 1
"colorscheme alduin

" light colorscheme
let ayucolor="light"
"colorscheme ayu

" gruvbox colorscheme
" https://github.com/morhetz/gruvbox
" colorscheme gruvbox

" codeschool for a brief refresh
colorscheme codeschool

" line at 80'th column ; this is optimal for a habit of writing good length
" code
set colorcolumn=80

" turns off -- INSERT -- messages and such as they're not needed anymore
set noshowmode

" bottom bar
if !has('gui_running')
    set t_Co=256
endif

set laststatus=2
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = '|'
let g:airline_theme= 'gruvbox'

" fuzzy finder
nnoremap <Leader>e :CtrlP<CR>

" unmap arrow keys :> i don't use them at all these days
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" active split selection
nmap <silent> <C-j> :wincmd h<CR>
nmap <silent> <C-k> :wincmd l<CR>

" arduino mappings
let g:arduino_serial_port_globs = ['/dev/ttyUSB*']
let g:arduino_dir = '~/arduino'
let g:arduino_serial_cmd = 'sleep 5 && wait $(pidof avrdude) && screen {port} {baud}'
nnoremap <buffer> <Leader>av :ArduinoVerify<CR>
nnoremap <buffer> <Leader>au :ArduinoUpload<CR>
nnoremap <buffer> <Leader>as :ArduinoUploadAndSerial<CR>
nnoremap <buffer> <Leader>ab :ArduinoChooseBoard<CR>
nnoremap <buffer> <Leader>ap :ArduinoChooseProgrammer<CR>
function! ArdStatusLine()
    let port = arduino#GetPort()
    let line = '[' . g:arduino_board . '] ['. g:arduino_programmer . ']'
    if !empty(port)
        let line = line .' (' . port . ':' . g:arduino_serial_baud . ')'
    endif
    return line
endfunction
autocmd BufNewFile,BufRead,BufEnter *.ino let g:airline_section_x='%{ArdStatusLine()}'

" Highlights for errors
highlight QuickFixLine cterm=bold ctermfg=none ctermbg=none guifg=none
highlight CocErrorVirtualText  cterm=bold ctermfg=none ctermbg=none guifg=#fb4934
highlight CocWarningVirtualText  cterm=bold ctermfg=none ctermbg=none guifg=#fabd2f
highlight CocInfoVirtualText  cterm=bold ctermfg=none ctermbg=none guifg=#83a598
highlight CocHintVirtualText  cterm=bold ctermfg=none ctermbg=none guifg=#8ec07c
highlight CocHighlightText  cterm=bold ctermfg=none ctermbg=none guifg=none guibg=#3c3836

" Yank Highlights
hi HighlightedyankRegion term=bold ctermbg=0 guibg=#cc241d

" Spell Checker Settings
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Polyglot
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1

" Open nerdtree when vim is launched with a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
