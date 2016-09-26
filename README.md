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

#### Mac

```
git clone https://github.com/mbasanta/vimfiles.git ~/.vim
```

#### Windows

```
git clone https://github.com/mbasanta/vimfiles.git ~/vimfiles
```

###Create symlinks:

#### Mac

```
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
```

#### Windows

Create a `_vimrc` file in `$HOME`. Content should be:

```
source ~/vimfiles/.vimrc
```

### Set up Vim-Plug

[Download plug.vim](https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)
and put it in the "autoload" directory.

#### Mac

```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

#### Windows (PowerShell)

```powershell
md ~\vimfiles\autoload
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile($uri, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~\vimfiles\autoload\plug.vim"))
```

- Open Vim and run `:PlugInstall`
- Run installation for YouCompleteMe
  [https://github.com/Valloric/YouCompleteMe](https://github.com/Valloric/YouCompleteMe#installation)
