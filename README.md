#vimfiles

##Make sure Lua is installed and supported by Vim

- Check with `:version`
- On a Mac
    - Install lua with Brew `brew install lua`
    - Vim configure with `--with-features=huge --enable-rubyinterp
      --enable-pythoninterp --enable-python3interp --enable-perlinterp
      --enable-cscope --enable-luainterp
      --with-lua-prefix=/usr/local/Cellar/lua/5.2.3_1`
- On a PC
    - TBD

##Vim Customizations

###Installation

```
git clone https://github.com/mbasanta/vimfiles.git ~/.vim
```

###Create symlinks:

```
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
```

###Set up Vundle

- Clone Vundle `git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
- Open Vim and run `:PluginInstall`
- Run installation for YouCompleteMe
  [https://github.com/Valloric/YouCompleteMe](https://github.com/Valloric/YouCompleteMe#installation)
