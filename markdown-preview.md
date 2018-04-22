## mac上实现vim的markdown预览

有时候在vim下创建了一个markdown文件，比如 `README.md` ，因为不能实时预览，所以要离开vim，用编辑器去编辑，比较麻烦。所以这里配置使能在vim编辑器上预览markdown文件。

这里分享两个插件

## **vim-instant-markdown**

### 下载

github：https://github.com/suan/vim-instant-markdown

下载zip文件，解压

```
ls vim-instant-markdown-master/
CHANGELOG.md README.md    after
```

### 安装

注意：需要依赖 node.js 和 npm

```
brew install npm
sudo npm -g install instant-markdown-d
```

### 拷贝文件

```
sudo mkdir -pv ~/.vim/after/ftplugin/markdown/
sudo cp after/ftplugin/markdown/instant-markdown.vim ~/.vim/after/ftplugin/markdown/
```

注意：保证在 `~/.vimrc` 中 `filetype plugin on`

```
filetype plugin indent on     " required!
```

> 一般是on的，特别是之前配置过vim插件的时候，已经打开了。

## **markdown-preview.vim**

Github：https://github.com/iamcco/markdown-preview.vim

相比较上面一种方法，这种比较轻量级，推荐此方法。

### 安装

第一步：在 `~/.vimrc` 中的插件部分添加如下代码

```
Plug 'iamcco/markdown-preview.vim'
```

第二步：安装插件

```
sudo vim		# 或者：sudo mvim
:BundleInstall
```

### 设置chrome为预览浏览器

在 `~/.vimrc` 的末尾添加如下配置

```
let g:mkdp_path_to_chrome = "open -a Google\\ Chrome"
```

### 预览

在编辑markdown的vim界面上敲如下命令

```
:MarkdownPreview
```

这时候就会在浏览器中出现markdown的预览界面

### 退出预览

```
:MarkdownPreviewStop
```

文件退出vim编辑的时候也会自动关闭和退出预览。

## zsh

如果不是用mac自带的bash，而是自己装的zsh，需要注意以下两点：

1、保证在安装 instant-markdown-d 的时候添加了选项 `npm -g install`

2、在 `~/.vimrc` 的末尾添加以下内容

```
set shell=bash\ -i
```

## 效果展示
第二种方法较第一种比较轻量级，而且不需要依赖node.js，不需要下载外部依赖，只需要支持python2/3就可以了，同时支持滚动。

这种配置在配合 mvim + hexo + markdown 的时候特别爽，可以实时显示，都省了先执行`hexo s`，然后登陆`localhost:4000` 去查看了。

本篇博客的实时预览截图如下：（可以看到，端口为9183）
![markdown-preview](http://oow6unnib.bkt.clouddn.com/markdown-preview.png)
