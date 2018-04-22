"设置vundle
set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'scrooloose/nerdtree'  
Bundle 'majutsushi/tagbar'    
Bundle 'wesleyche/SrcExpl'    
Bundle 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'
Bundle 'tpope/vim-Surround'
Bundle 'scrooloose/nerdcommenter'
Plugin 'vim-syntastic/syntastic'
Plugin 'Raimondi/delimitMate'
Plugin 'iamcco/markdown-preview.vim'
Plugin 'fatih/vim-go'
Plugin 'tmhedberg/SimpylFold'
Plugin 'Yggdroot/indentLine'

filetype plugin indent on     " required!
"vundle设置完毕

set nu
syntax on
set ts=4
set expandtab
set showmatch
" set cindent
set hlsearch
" set autoindent
set shiftwidth=4

let g:tagbar_ctags_bin='/usr/local/bin/ctags'
let g:tagbar_left = 1
nnoremap <F3> :TagbarToggle<CR>
let NERDTreeWinPos='right'
nnoremap <F2> :NERDTreeToggle<CR>
nmap <F4> :SrcExplToggle<CR>
let g:Srcexpl_winHeight = 8
" // Set 100 ms for refreshing the Source Explorer 
let g:SrcExpl_refreshTime = 100

" // Set "Enter" key to jump into the exact definition context 
let g:SrcExpl_jumpKey = "<ENTER>"

" // Set "Space" key for back from the definition context 
let g:SrcExpl_gobackKey = "<SPACE>"

let g:SrcExpl_pluginList = [
          \ "__Tag_List__",
                           \ "_NERD_tree_"
                                                \ ]


set tags=tags;/  "搜索上一级建立的tag
set autochdir



nmap <C-H> <C-W>h "control+h进入左边的窗口
nmap <C-J> <C-W>j  "control+j进入下边的窗口
nmap <C-K> <C-W>k "control+k进入上边的窗口
nmap <C-L> <C-W>l  "control+l进入右边的窗口
let g:Tlist_Ctags_Cmd='/usr/local/bin/ctags'
set backspace=2
set nu

syntax enable
set background=dark
colorscheme solarized

" Airline相关
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"设置切换Buffer快捷键"
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>

" syntastic语法检查
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" 
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" 设置错误符号
let g:syntastic_error_symbol='✗'
" 设置警告符号
let g:syntastic_warning_symbol='⚠'

" 括号间回车分3行缩进
let delimitMate_expand_cr = 1

cs add cscope.out
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" MarkdownPreview on Chrome
set shell=bash\ -i
let g:mkdp_path_to_chrome = "open -a Google\\ Chrome"

" Enable folding
set foldmethod=indent
set foldlevel=99

" 配色方案
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme Zenburn
endif

" gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }

" 保存时自动格式化代码格式
autocmd BufWritePre *.go :Fmt

" 缩进指示线
" let g:indentLine_char='┆'
let g:indentLine_enabled = 0

" 突出显示当前行
set cursorline        

" <F5> 运行python程序  
map <F5> :w<cr>:!python3 %<cr>  
  
