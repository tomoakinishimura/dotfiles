#!/bin/bash

# neobundle setting
mkdir -p ~/.vim/bundle    
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# vimproc setting
cd ../.vim/bundle/vimproc
make -f make_unix.mak
  
