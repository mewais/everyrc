# everyrc

This repo includes a bunch of commands and a bunch of configuration files that I use. I got tired of having to do this every time I make a fresh installation, so I'm just rounding everything up over here.

On a fresh Linux installation, run the following:
```bash
sudo apt install git
git clone https://gitlab.com/mewais/everyrc
cd everyrc
./setup.sh
```
This is an interactive script that will ask you for some inputs as well as the sudo password. It will install everythin needed and setup zsh, neovim, and my ssh config.

## VIM
Run the following to completely setup vim
```bash
:PackerInstall
:COQdeps
```
