## vim的查找与替换

## 查找

在normal模式下按下`/`即可进入查找模式，输入要查找的字符串并按下回车。 Vim会跳转到第一个匹配。按下`n`查找下一个，按下`N`查找上一个。

Vim查找支持正则表达式，例如`/vim$`匹配行尾的`"vim"`。 需要查找特殊字符需要转义，例如`/vim\$`匹配`"vim$"`。

### 大小写敏感查找

在查找模式中加入`\c`表示大小写不敏感查找，`\C`表示大小写敏感查找。例如：

```
/foo\c
```

将会查找所有的`"foo"`,`"FOO"`,`"Foo"`等字符串。

### 大小写敏感配置

Vim 默认采用大小写敏感的查找，为了方便我们常常将其配置为大小写不敏感：

```
" 设置默认进行大小写不敏感查找
set ignorecase
" 如果有一个大写字母，则切换到大小写敏感查找
set smartcase 

```

> 将上述设置粘贴到你的`~/.vimrc`，重新打开Vim即可生效。

### 查找当前单词

在normal模式下按下`*`即可查找光标所在单词（word）， 要求每次出现的前后为空白字符或标点符号。例如当前为`foo`， 可以匹配`foo bar`中的`foo`，但不可匹配`foobar`中的`foo`。 这在查找函数名、变量名时非常有用。

按下`g*`即可查找光标所在单词的字符序列，每次出现前后字符无要求。 即`foo bar`和`foobar`中的`foo`均可被匹配到。

## 替换

`:s`（substitute）命令用来查找和替换字符串。语法如下：

```
:{作用范围}s/{目标}/{替换}/{替换标志}

```

例如`:%s/foo/bar/g`会在全局范围(`%`)查找`foo`并替换为`bar`，所有出现都会被替换（`g`）。

### 作用范围

作用范围分为当前行、全文、选区等等。

当前行：

```
:s/foo/bar/g

```

全文：

```
:%s/foo/bar/g
```

选区，在Visual模式下选择区域后输入`:`，Vim即可自动补全为 `:'<,'>`。

```
:'<,'>s/foo/bar/g

```

2-11行：

```
:5,12s/foo/bar/g

```

当前行`.`与接下来两行`+2`：

```
:.,+2s/foo/bar/g
```

## 替换标志

命令结尾的 `g` 表示global替换，表示对搜索字符串的每次出现进行替换。

空替换标志表示只替换从光标位置开始，目标的第一次出现：

```
:%s/foo/bar

```

`i`表示大小写不敏感查找，`I`表示大小写敏感：

```
:%s/foo/bar/i
# 等效于模式中的\c（不敏感）或\C（敏感）
:%s/foo\c/bar

```

`c`表示需要确认，例如全局查找`"foo"`替换为`"bar"`并且需要确认：

```
:%s/foo/bar/gc

```

回车后Vim会将光标移动到每一次`"foo"`出现的位置，并提示

```
replace with bar (y/n/a/q/l/^E/^Y)?

```

按下`y`表示替换，`n`表示不替换，`a`表示替换所有，`q`表示退出查找模式， `l`表示替换当前位置并退出。`^E`与`^Y`是光标移动快捷键

如果替换文本中包含 `/`，可以使用 `#` 作为分隔符，此时中间出现的 `/` 不会作为分隔符

```
:s#vivian/#sky/#
```

替换当前行第一个 `vivian/` 为 `sky/`

## 高亮设置

### 禁用/启用高亮

每次查找替换后 Vim 仍然高亮着搜索结果？ 可以手动让它停止高亮，在normal模式下输入：

```
:nohighlight
" 等效于
:nohl
```

上述命令禁用了所有高亮

如果只禁用搜索高亮的命令是`:set nohlsearch`，下次搜索时需要`:set hlsearch`再次启动搜索高亮。

### 延时禁用

怎么能够让Vim查找/替换后一段时间自动取消高亮，发生查找时自动开启呢？

```
" 当光标一段时间保持不动了，就禁用高亮
autocmd cursorhold * set nohlsearch
" 当输入查找命令时，再启用高亮
noremap n :set hlsearch<cr>n
noremap N :set hlsearch<cr>N
noremap / :set hlsearch<cr>/
noremap ? :set hlsearch<cr>?
noremap * *:set hlsearch<cr>

```

> 将上述配置粘贴到`~/.vimrc`，重新打开vim即可生效。

### 高亮颜色设置

如果觉得高亮的颜色不太舒服，可以在 `~/.vimrc` 中进行设置：

```
highlight Search ctermbg=yellow ctermfg=black 
highlight IncSearch ctermbg=black ctermfg=yellow 
highlight MatchParen cterm=underline ctermbg=NONE ctermfg=NONE
```

上述配置指定 Search 结果的前景色（foreground）为黑色，背景色（background）为灰色； 渐进搜索的前景色为黑色，背景色为黄色；光标处的字符加下划线。

> 更多的CTERM颜色可以查阅：[http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim](http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim)

### 删除/插入每行前/后n个字符

1、删除每行前10个字符

```
:%s/^.\{10\}//
```

正则表达式`/^.\{10\}//`中，^表示行首；"."表示要删除的字符个数，".\{10\}"表示删除10个字符，可用10个"."表示。

2、删除每行后10个字符

```
:%s/.\{10\}$//
```

"$"表示行尾

3、每行的行首都添加一个字符串

```
:%s/^/要插入的字符串
```

4、每行的行尾都添加一个字符串

```
:%s/$/要插入的字符串
```

### 删除每行行首/行尾多余的空格

行末：`$ `
行首：`^`
空格：`\s`

行末空格：`\s\+$`
行首空格：`^\+\s`

1、删除每行行首空格

```
:%s/^\+\s//
```

2、删除每行行尾空格

```
:%s/\s\+$//
```

