## 多文件编辑

### 多标签

**1、启动多个标签页**

使用`-p`参数

```
vim -p a.txt b/c.txt
```

**2、打开和关闭标签**

```
:tabe[dit] {file}   edit specified file in a new tab
:tabf[ind] {file}   open a new tab with filename given, searching the 'path' to find it
:tabc[lose]         close current tab
:tabc[lose] {i}     close i-th tab
:tabo[nly]          close all other tabs (show only the current tab)
```

> 中括号中的部分可以省略，在Vim中`:h tabedit`可以查看命令帮助。

**3、标签跳转**

```
:tabn         go to next tab
:tabp         go to previous tab
:tabfirst     go to first tab
:tablast      go to last tab
```

在 normal 模式下，可以使用快捷键：

```
gt            go to next tab
gT            go to previous tab
{i}gt         go to tab in position i 

```

还可以设置更通用的切换标签页快捷键，比如：

```
# cat ~/.vimrc
...
noremap <C-L> <Esc>:tabnext<CR>
noremap <C-H> <Esc>:tabprevious<CR>
...
```

**4、移动标签**

```
:tabs         list all tabs including their displayed window
:tabm 0       move current tab to first
:tabm         move current tab to last
:tabm {i}     move current tab to position i+1
```

