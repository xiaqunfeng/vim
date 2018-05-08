## 多文件编辑

* [标签](#标签)
* [窗口](#窗口)
* [缓冲区](#缓冲区)

### 标签

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

### 窗口

**1、分屏打开多个文件**

使用`-O`参数可以让Vim以垂直分屏的方式打开多个文件：

```
vim -O main.cpp my-oj-toolkit.h

```

> 使用小写的`-o`可以水平分屏。

**2、打开关闭命令**

在进入Vim后，可以使用这些命令来打开/关闭窗口：

```
:sp[lit] {file}     水平分屏
:new {file}         水平分屏
:sv[iew] {file}     水平分屏，以只读方式打开
:vs[plit] {file}    垂直分屏
:clo[se]            关闭当前窗口

```

> 上述命令中，如未指定file则打开当前文件。

**3、打开关闭快捷键**

上述命令都有相应的快捷键，它们有共同的前缀：`Ctrl+w`。

```
Ctrl+w s        水平分割当前窗口
Ctrl+w v        垂直分割当前窗口
Ctrl+w q        关闭当前窗口
Ctrl+w n        打开一个新窗口（空文件）
Ctrl+w o        关闭出当前窗口之外的所有窗口
Ctrl+w T        当前窗口移动到新标签页
```

**4、切换窗口**

切换窗口的快捷键就是`Ctrl+w`前缀 + `hjkl`：

```
Ctrl+w h        切换到左边窗口
Ctrl+w j        切换到下边窗口
Ctrl+w k        切换到上边窗口
Ctrl+w l        切换到右边窗口
Ctrl+w w        遍历切换窗口

```

> 还有`t`切换到最上方的窗口，`b`切换到最下方的窗口。

**5、移动窗口**

分屏后还可以把当前窗口向任何方向移动，只需要将上述快捷键中的`hjkl`大写：

```
Ctrl+w H        向左移动当前窗口
Ctrl+w J        向下移动当前窗口
Ctrl+w K        向上移动当前窗口
Ctrl+w L        向右移动当前窗口
```

**6、调整大小**

调整窗口大小的快捷键仍然有`Ctrl+W`前缀：

```
Ctrl+w +        增加窗口高度
Ctrl+w -        减小窗口高度
Ctrl+w =        统一窗口高度
```

### 缓冲区

**1、打开与关闭**

不带任何参数打开多个文件便可以把它们都放入缓冲区（Buffer）：

```
vim a.txt b.txt

```

> 当你使用`:q`关闭文件时？是否看到过`1 more file to edit`的警告？那就是缓冲区中的文件。

进入Vim后，通过`:e[dit]`命令即可打开某个文件到缓冲区。使用`:new`可以打开一个新窗口。 关闭一个文件可以用`:q`，移出缓冲区用`:bd[elete]`（占用缓冲区的文件对你毫无影响，多数情况下不需要这样做）。

> 如果Buffer未保存`:bd`会失败，如果强制删除可以`:bd!`。

**2、缓冲区跳转**

缓冲区之间跳转最常用的方式便是 `Ctrl+^`（不需要按下Shift）来切换当前缓冲区和上一个缓冲区。 另外，还提供了很多跳转命令：

```
:ls, :buffers       列出所有缓冲区
:bn[ext]            下一个缓冲区
:bp[revious]        上一个缓冲区
:b {number, expression}     跳转到指定缓冲区

```

`:b`接受缓冲区编号，或者部分文件名。例如：

- `:b2`将会跳转到编号为2的缓冲区，如果你正在用`:ls`列出缓冲区，这时只需要输入编号回车即可。
- `:b exa`将会跳转到最匹配`exa`的文件名，比如`example.html`，**模糊匹配打开文件正是Vim缓冲区的强大之处**。

**3、分屏**

前面已经介绍了Vim中分割屏幕的操作。 其实分屏时还可以指定一个Buffer在新的Window中打开。

```
:sb 3               分屏并打开编号为3的Buffer
:vertical sb 3      同上，垂直分屏
:vertical rightbelow sfind file.txt

```

注意`sfind`可以打开在Vim PATH中的任何文件。这当然需要我们设置PATH，一个通用的做法是在`~/.vimrc`中添加：

```
" 将当前工作路径设为Vim PATH
set path=$PWD/**

```

**4、利用通配符进行缓冲区跳转**

这是缓冲区最强大的功能之一。我们可以使用通配符来指定要跳转到的缓冲区文件名。 在此之前，我们启动`wildmenu`并设置匹配后文件选择模式为`full`。 `wildchar`为选择下一个备选文件的快捷键， 而`wildcharm`用于宏定义中（语义同`wildchar`），比如后面的`noremap`。

```
set wildmenu wildmode=full 
set wildchar=<Tab> wildcharm=<C-Z>

```

比如现在按下打开这些文件：

```
vehicle.c vehicle.h car.c car.h jet.c jet.h jetcar.c jetcar.h

```

然后按下`:b `便可看到Vim提供的备选文件列表了， 按下``选择下一个，按下回车打开当前文件。

```
:b <Tab>       " 显示所有Buffer中的文件
:b car<Tab>    " 显示 car.c car.h
:b *car<Tab>   " 显示 car.c jetcar.c car.h jetcar.h
:b .h<Tab>     " 显示 vehicle.h car.h jet.h jetcar.h
:b .c<Tab>     " 显示 vehicle.c car.c jet.c jetcar.c
:b ar.c<Tab>   " 显示 car.c jetcar.c
:b j*c<Tab>    " 显示 jet.c jetcar.c jetcar.h

```

我们可以为`:b `设置一个快捷键``，这时便用到上文中设置的`wildcharm`了：

```
noremap <c-n> :b <c-z>
```