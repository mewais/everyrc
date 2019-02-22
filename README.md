# everyrc

This repo includes a bunch of commands and a bunch of configuration files that I use. I got tired of having to do this every time I make a fresh installation, so I'm just rounding everything up over here.

On a fresh Linux installation, run the following:
```bash
sudo apt update
sudo apt upgrade
sudo apt install neovim python3 python3-dev build-essential git wget tmux npm cmake exuberant-ctags fonts-powerline python-pip powerline
```

Then once we are settled, clone this repo.
```bash
git clone https://gitlab.com/mewais/everyrc .
git submodule init
git submodule update
```

## VIM
Run the following to completely setup vim
```bash
vim +PluginInstall +qall
cd ~/.vim/bundle/YouCompleteMe && python3 install.py --clang-completer && cd -
```

## VTOP
Run the following to install vtop
```bash
sudo npm install -g vtop
```

## TMUX
Run the following to get the color schemes for tmux
```bash
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
```
