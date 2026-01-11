" 
" vimrc like a boss
" <cam@onswipe.com>
"

" all mouse functionality
set mouse=a

" spaces > tabs
set tabstop=2
set shiftwidth=2
set expandtab

" F5 for nerdtree
map <F5> :NERDTreeToggle<CR>

" syntax highlighting
syntax on

" colors
hi User1 guifg=#eea040 guibg=#222222
hi User2 guifg=#dd3333 guibg=#222222
hi User3 guifg=#ff66ff guibg=#222222
hi User4 guifg=#a0ee40 guibg=#222222
hi User5 guifg=#eeee40 guibg=#222222

" status bar
set wildmenu
set laststatus=2

" line numbers
set number

" vim-tmux-navigator - seamless navigation between vim and tmux panes
" Ctrl-h/j/k/l to move between splits (works across vim and tmux)
" Install plugin: https://github.com/christoomey/vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<CR>
