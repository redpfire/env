
" NeoVim 'vimrc' of aika

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

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-tern',  {'do': 'npm install'}
Plug 'ncm2/ncm2-cssomni'
Plug 'ncm2/ncm2-racer'

" expanding autocompletion
" https://github.com/ncm2/ncm2-snipmate

Plug 'ncm2/ncm2-snipmate'
Plug 'tomtom/tlib_vim'
Plug 'marcweber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'

" bottom bar
" https://github.com/vim-airline/vim-airline

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" gruvbox theme
Plug 'morhetz/gruvbox'

" light theme
Plug 'ayu-theme/ayu-vim'

call plug#end()
filetype on
set relativenumber

" expand completion on <Return>
inoremap <silent> <expr> <CR> ncm2_snipmate#expand_or("\<CR>", 'n')

" scrolling thru autocompletion menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" enable autocompletion for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
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

command! Q q " map that annoying shift Q to normal q

" buffer navigation
nnoremap <Leader>k :bnext!<CR>
nnoremap <Leader>j :bprevious!<CR>
nnoremap <Leader>l :CtrlPBuffer<CR>
nnoremap <Leader>q :bdelete<CR>

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

nnoremap ; :
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
colorscheme gruvbox

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
