" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

let skip_defaults_vim=1

filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

set number          " 显示行号
syntax on           " 语法高亮
autocmd InsertLeave * se nocul  " 用浅色高亮当前行
autocmd InsertEnter * se cul    " 用浅色高亮当前行
set ruler           " 显示标尺
set autoindent      " 设置自动缩进
set backspace=2
set nowrap          " 不自动换行
set tabstop=4       " tab相当于四个字符
set softtabstop=4   " 按一次tab前进4个字符
set expandtab       " 用空格代替tab
set ai!             " 设置自动缩进
set cindent shiftwidth=4 " 缩进的字符个数
set hlsearch        " 高亮搜索的关键字
set ignorecase      " 搜索忽略大小写
set history=100     " 设置命令历史行数
:set mouse=a        " 在vim所有模式下开鼠标，复制文档就可以不包含行号了
set showmatch       " 插入括号时，短暂地跳转到匹配的对应括号
set smartindent     " 开启新行时使用智能自动缩进

let g:molokai_original = 1
let g:rehash256 = 1
