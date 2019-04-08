" vim settings 
" author : bug

set nocompatible
filetype off

" add to rumtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
" complete python
Plugin 'davidhalter/jedi'
" Plugin 'tmhedberg/SimpyFold'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'Valloric/YouCompleteMe'
" other plugin
Plugin 'fatih/vim-go'
Plugin 'mileszs/ack.vim'
Plugin 'taglist.vim'
"

call vundle#end()
filetype plugin indent on

" syntax hightlight
syntax enable

" set syntax highlighting for specific file types
autocmd BufRead,BufNewFile Appraisals set filetype=ruby
autocmd Syntax javascript set syntax=jquery

" backspace deletes
set backspace=2
" show the cursor position all the time
set ruler
" display incomplete commands
set showcmd
" set fileencodings
set fileencodings=utf-8,gb18030,gbk,gb2312,big5

" softtabs,2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" 80 characters width set
set textwidth=80
set colorcolumn=+1

set foldmethod=syntax

" show numbers
set number
set numberwidth=5

set matchpairs+=<:>
set hlsearch

" highlight current line
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" NERD tree
let NERDChristmasTree=0
let NERDTreeWinSize=20
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$','\.pyc$','\.swp$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="left"
" autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <C-n> :NERDTree<CR>

" add header when create python file
autocmd BufNewFile *.py exec ":call SetPythonTitle()"

func SetPythonTitle()
  call setline(1,"#!/usr/bin/env python")
  call append(line("."),"#-*- coding: utf-8 -*-")
  call append(line(".")+1," ")
  call append(line(".")+2, "\# File Name: ".expand("%"))
  call append(line(".")+3, "\# Author: Changsong Deng")
  call append(line(".")+4, "\# Mail: csdeng1989@gmail.com")
  call append(line(".")+5, "\# Created Time: ".strftime("%Y-%m-%d",localtime()))
endfunc

autocmd BufNewFile *.h exec ":call SetCTitle()"
autocmd BufNewFile *.c exec ":call SetCTitle()"
autocmd BufNewFile *.cpp exec ":call SetCTitle()"

func SetCTitle()
  call setline(1,"/**********************************")
  call append(line("."),"** File Name: ".expand("%"))
  call append(line(".")+1,"** Author: Changsong Deng")
  call append(line(".")+2,"** Mail: csdeng1989@gmail.com")
  call append(line(".")+3,"** Created Time: ".strftime("%Y-%m-%d",localtime()))
  call append(line(".")+4,"***********************************/")
endfunc

" begin go settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" enable goimports to automatically insert import paths instead of gofmt
let g:go_fmt_command = "goimports"
" by default vim-go shows errors for the fmt command,to disable it:
let g:go_fmt_fail_silently = 1

" fix vim start lagging while saving and opening files
let g:syntastic_go_checkers = ['golint','govet','errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go']}
" resolve the output of commands such as :GoBuild not appear
let g:go_list_type = "quickfix"

" autocmd BufNewFile *.go exec ":call SetCTitle()"

" end go settings

" ctags settings
let Tlist_Sort_Type = "name"
let Tlist_Use_Right_Window = 1
let Tlist_Compart_Format = 1
let Tlist_Exist_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 0
let Tlist_Enable_Fold_Column = 0

set tags+=~/.vim/tags/stl_source/tags
nmap <C-F12> :ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"
" cscope
set cscopequickfix=s-,c-,d-,i-,t-,e-

" ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" hot key of gotodefinition
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
" hot key of gotodeclaration
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
