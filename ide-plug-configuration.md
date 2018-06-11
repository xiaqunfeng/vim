## vim/mvim编辑器的配置

**目  录**
* [将vim打造成IDE](#将vim打造成ide)
* [安装Vundle](#安装vundle)
* [实用插件](#实用插件)
   * [YouCompleteMe](#youcompleteme)
   * [ctags](#ctags)
   * [cscop](#cscop)
   * [nerdtree](#nerdtree)
   * [tagbar](#tagbar)
   * [SrcExpl](#srcexpl)
   * [surround](#surround)
   * [Airline](#airline)
   * [Tabular](#tabular)
   * [Solarized](#solarized)
   * [syntastic](#syntastic)
   * [nerdcommenter](#nerdcommenter)
* [问题汇总](#问题汇总)
   * [1、关于YCM](#1关于ycm)
   * [2、关于ctags](#2关于ctags)
* [一些vim的设置](#一些vim的设置)
* [自己的配置](#自己的配置)

## 将vim打造成IDE

如下，根据自己的需求安装插件，可实现类似于source insight的代码IDE。

## 安装Vundle

Vundle (缩写自 `Vim bundle`) 是一个很方便的 Vim 插件管理器。安装一个插件只需要在 `.vimrc` 按照规则中添加 Plugin 的名称，某些需要添加路径，之后在 Vim 中使用 `:PluginInstall` 或者 `:BundleInstall` 既可以自动化安装。

官网：https://github.com/VundleVim/Vundle.vim

安装

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

打开vimrc文件

```
vim .vimrc
```

添加如下代码

```
set nocompatible              " be iMproved, required
filetype off                  " required

" 启动vundle来管理插件
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
#所有的插件命令写在这之后

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
#如果你的插件来自github，写在下方，只要作者名/项目名就行了
Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
#如果插件来自 vim-scripts，你直接写插件名就行了
Plugin 'L9'

" Git plugin not hosted on GitHub
#如使用自己的git库的插件，像下面这样做
Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
#插件如果已经下载在本机上，可以如下方式安装(不怎么用)
Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
Plugin 'ascenator/L9', {'name': 'newL9'}

#所有的插件命令写在这之前
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
```

## 实用插件

### YouCompleteMe

功能：代码自动补全

官网：[YouCompleteMe](https://github.com/Valloric/YouCompleteMe) 

这个安装比较慢，耐心等待

写代码的时候，table键选择自动补全的代码，space键选中

### ctags

功能：实现代码跳转

安装

```
apt-get install ctags
```

修改配置文件

```
echo "let g:Tlist_Ctags_Cmd='/usr/local/bin/ctags'" >>~/.vimrc
```

在代码的根目录下

```
ctags -R *
```

这样就可以了通过快捷键实现跳转了

```
ctrl + ] 实现跳转
ctrl + t 跳回来	// 或者 ctrl + o
```

### cscop

功能：用于各种Symbol的搜索和跳转，包括但不限于源文件名，函数，变量，宏，结构体定义。

```
apt-get install cscope
```

代码根目录下

```
cscope -Rbq
```

ctags虽然已经相当不错了，但是仍然无法解决一些问题，例如查看函数被哪些函数调用，函数调用了哪些函数，查找该头文件被哪些文件包含等等，而解决这些问题，就需要用到cscope了。cscope不是Vim插件，而是一个工具，因此需要在终端进行安装。cscope的原理其实和ctags一样，也需要事先扫描项目目录，生成相关信息文件，方便之后查找的时候使用，cscope生成的数据文件为 `cscope.out` 和 `cscope.in.out`。

```
" Cscope 设置
if has("cscope")
    set csprg=/usr/bin/cscope   "指定用来执行cscope的命令
    set csto=0                  " 设置cstag命令查找次序：0先找cscope数据库再找标签文件；1先找标签文件再找cscope数据库"
    set cst                     " 同时搜索cscope数据库和标签文件"
    set cscopequickfix=s-,c-,d-,i-,t-,e-    " 使用QuickFix窗口来显示cscope查找结果"
    set nocsverb
    if filereadable("cscope.out")    " 若当前目录下存在cscope数据库，添加该数据库到vim
        cs add cscope.out
    elseif $CSCOPE_DB != ""            " 否则只要环境变量CSCOPE_DB不为空，则添加其指定的数据库到vim
        cs add $CSCOPE_DB
    endif
    set csverb
endif
map <F4>:!cscope -Rbq<CR>:cs add ./cscope.out .<CR><CR><CR> :cs reset<CR>
"对:cs find c等Cscope查找命令进行映射
nmap <leader>s :cs find s <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>d :cs find d <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR><CR>
nmap <leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR><CR>
nmap <leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR><CR>
nmap <leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>i :cs find i <C-R>=expand("<cfile>")<CR><CR> :copen<CR><CR>
" 设定是否使用 quickfix 窗口来显示 cscope 结果
set cscopequickfix=s-,c-,d-,i-,t-,e-
```

cscope生成数据文件的命令为：`cscope -Rbq` ，`-R` 表示在生成索引文件时，搜索子目录树中的代码；`-b` 表示只生成索引文件，不进入cscope的界面；`-q` 表示生成 `cscope.in.out` 和 `cscope.po.out` 文件，加快cscope的索引速度。我们的配置文件将``键映射成了cscope命令，同时将生成的cscope.out文件加入到当前索引文件中。(由于cscope和ctags往往配合一同使用，而且都需要事先生成数据文件，所以本人直接将ctags和cscope生成数据文件的操作组合起来，绑定到了一组组合键上：`nmap tg :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q * :set tags+=./tags:!cscope -Rbq:cs add ./cscope.out .` ，键位绑定这东西，仁者见仁，智者见智，根据自己的喜好来。)

cscope基本操作：

| key          | Description          |
| ------------ | -------------------- |
| `:cs find s` | 查找这个C符号              |
| `:cs find g` | 查找这个定义               |
| `:cs find d` | 查找被这个函数调用的函数（们）      |
| `:cs find c` | 查找调用这个函数的函数（们）       |
| `:cs find t` | 查找这个字符串              |
| `:cs find e` | 查找这个egrep匹配模式        |
| `:cs find f` | 查找这个文件               |
| `:cs find i` | 查找#include这个文件的文件（们） |

find可以简写为f, 所以命令可以写成`:cs f s symbol_name`

参考上面cscope的配置语句，我们将 `:cs find` 操作映射成了 `` ，这样方便很多。`nmap s :cs find s =expand("") :copen` ，这里我们主要关注下这条语句后面的内容，其中 `=expand("")` 代表当前光标所在地方的单词，而 `:copen`则是打开Vim中内置的一个称之为 `quickfix` 的窗口用于显示查找的结果。

对我而言，我看代码时最常用的就是 `ctrl+]` ，`ctrl+o` 和 `:cs find c` 了。

关于cscope的详细信息，请在终端运行 `man cscope` 。

参考资料：http://fancyseeker.github.io/2014/05/15/vim1/

http://fancyseeker.github.io/2014/05/16/vim2/

### nerdtree

功能：文件浏览树状机构

官网：https://github.com/scrooloose/nerdtree

```
# 配置按F2打开
nnoremap <F2> :NERDTreeToggle<CR>
```

或者

```
# 配置按 ctrl + n 打开
map <C-n> :NERDTreeToggle<CR>
```

### tagbar

功能：代码符号，类似于source insight的左边，文件函数和符号列表

官网：https://github.com/majutsushi/tagbar

```
# 配置按 F3 打开
nnoremap <F3> :TagbarToggle<CR>
```

### SrcExpl

功能：类似sourceInsight的代码预览窗口

官网：https://github.com/wesleyche/SrcExpl

```
# 配置按 F4 打开
nmap <F4> :SrcExplToggle<CR>
```

7、taglist

​	文件的Symbol列表。

### surround

用来加括号，引号，前后缀等等

https://github.com/tpope/vim-surround

```
Bundle 'tpope/vim-surround'
```

在写代码的时候，括号和引号会成对的出现，比较方便

vim-repeat通常和surround配合一起使用

https://github.com/tpope/vim-repeat

```
" for repeat -> enhance surround.vim, . to repeat command
Bundle 'tpope/vim-repeat'
```

### Airline

```
" Airline: 小巧美观的状态栏。
Plugin 'bling/vim-airline'
```

https://github.com/vim-airline/vim-airline

```
" 映射切换buffer的键位
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
```

比如打开了A、B、C三个文件，Vim并不将这三个文件的buffer显示出来。只能通过 `:ls` 来查看buffer，然后通过 `:bn` (buffer next)和 `:bp` (buffer previous)，或者 `:b num` (打开编号为num的buffer)这样的命令来切换不同文件。

也可以通过设置映射切换符的方式，比如上面的代码，将切换到前一个buffer的命令 `:bp` 映射成了 `[b` ，将切换至后一个buffer的命令 `:bn` 映射成了 `]b` (这实际上是airline作者的映射)

### Tabular

```
" Tabular: 自动对齐。
Plugin 'godlygeek/tabular'
```

https://github.com/godlygeek/tabular

### Solarized

```
" Solarized: 非常流行的配色。
Plugin 'altercation/vim-colors-solarized'
```

https://github.com/altercation/vim-colors-solarized

有dark和light两种主题，可以去github上查看详细配置方法

### syntastic

语法检查

https://github.com/vim-syntastic/syntastic

```
Plugin 'vim-syntastic/syntastic'
```

配置

```
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" 设置错误符号
let g:syntastic_error_symbol='✗'
" 设置警告符号
let g:syntastic_warning_symbol='⚠'
```

### nerdcommenter

注释、反注释

[https://github.com/scrooloose/nerdcommenter](https://github.com/scrooloose/nerdcommenter)

```
Bundle 'scrooloose/nerdcommenter'
```

如果想把默认的leader从“\”改为“,”， 则在在配置文件.vimrc中，加入下面一行

```
let mapleader=","
```

注：这里已经将"\"改为","

　　简单介绍下NERD Commenter的常用键绑定，以C/C++文件为例，详析的使用方法，请:h NERDCommenter。

在Normal或者Visual 模式下：

- ,ca，在可选的注释方式之间切换，比如C/C++ 的块注释/* */和行注释//
- ,cc，注释当前行
- ,c，切换注释/非注释状态
- ,cs，以”性感”的方式注释
- ,cA，在当前行尾添加注释符，并进入Insert模式
- ,cu，取消注释
- Normal模式下，几乎所有命令前面都可以指定行数。  比如  输入  6,cs    的意思就是以性感方式注释光标所在行开始6行代码
- Visual模式下执行命令，会对选中的特定区块进行注释/反注释

```
1、 \cc 注释当前行和选中行   
3、 \c<空格> 如果被选区域有部分被注释，则对被选区域执行取消注释操作，其它情况执行反转注释操作  
\cA 跳转到该行结尾添加注释，并进入编辑模式  
\cm 对被选区域用一对注释符进行注释，前面的注释对每一行都会添加注释  
5、 \ci 执行反转注释操作，选中区域注释部分取消注释，非注释部分添加注释  
6、 \cs 添加性感的注释，代码开头介绍部分通常使用该注释  
122 /*
123  *
124  */

7、 \cy 添加注释，并复制被添加注释的部分  
8、 \c$ 注释当前光标到改行结尾的内容  
9、 
10、\ca 转换注释的方式，比如： /**/和//  
11、\cl \cb 左对齐和左右对其，左右对其主要针对/**/  
12、\cu 取消注释  
```

## 问题汇总

### 1、关于YCM

**问题1：**

```
YouCompleteMe unavailable: requires Vim 7.4.143+
```

解决方法：更新最新的vim

```
sudo add-apt-repository ppa:jonathonf/vim
sudo apt-get update && sudo apt-get upgrade
```

**问题2：**

```
YouCompleteMe unavailable: requires Vim compiled with Python (2.6+ or 3.3+)
```

解决该错误有两个方法：

方法一：自己进行[源码](http://m.2cto.com/ym/)编译，vim 插件 youcompleteme full install

方法二：下载一个特殊版本的vim（推荐）

```
apt-get install vim-nox
```

**问题3：**

```
./install.py --clang-completer
```

执行上面脚本的时候出现各种不成功

解决方法：

```
git submodule update --init --recursive
```

### 2、关于ctags

**问题：**

```
e433 no tags file
```

解决方法

第一步：打开vimrc

```
vim ~/.vimrc
```

第二步：在文件末尾添加如下代码

```
set tags=./tags,tags;$HOME
```

第三步：在代码的根目录下

```
ctag -R *
```

## 一些vim的设置

默认vim的缩进宽度为8个空格，修改缩进的宽度：`:set shiftwidth=4`

## 自己的配置

```
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" Plugin 'Valloric/YouCompleteMe'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'wesleyche/SrcExpl'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Chiel92/vim-autoformat'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Plugin 'scrooloose/syntastic'

" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

# 行号、高亮、table=4个空格、括号匹配、c格式对齐、匹配高亮
set nu
syntax on
set ts=4
set showmatch
set cindent
set hlsearch
set shiftwidth=4

# 快捷键，F2打开目录，F3打开文件的函数和符号列表，F4打开代码预览
nnoremap <F3> :TagbarToggle<CR>
nnoremap <F2> :NERDTreeToggle<CR>
nmap <F4> :SrcExplToggle<CR>

# ctrl + h,j,k,l 控制指针所在的布局
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

set tags=/root/qbs

# neardstree默认配置
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

# Airline相关
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

 "设置切换Buffer快捷键"
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>

# syntastic相关
" syntastic语法检查
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" 设置错误符号
let g:syntastic_error_symbol='✗'
" 设置警告符号
let g:syntastic_warning_symbol='⚠'

# ctags相关
set tags=./tags,tags;$HOME
                                                       
```
