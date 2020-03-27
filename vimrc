set nu
set fileencodings=utf-8,gb2312,gbk,gb18030
set fileformats=unix,dos,mac
set hlsearch
" Tab键的宽度
set tabstop=4
" Tab转为空格
set expandtab
" 换行时,自动获取当前行的缩进
set autoindent
" 开启C语言的缩进风格
set cindent
"键盘配置
" 映射全选+复制 ctrl+a
map <C-A> ggVGY
" 自动缩进为4空格
set shiftwidth=4
" 检测文件类型
filetype on
" 语法高亮
syntax on