# everyrc

This repo includes a bunch of commands and a bunch of configuration files that I use. I got tired of having to do this every time I make a fresh installation, so I'm just rounding everything up over here.

On a fresh Linux installation, run the following:
```bash
sudo apt install apt-transport-https curl
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt upgrade
sudo apt install neovim python3 python3-dev build-essential git wget screen cmake exuberant-ctags fonts-powerline python3-pip powerline brave-browser
sudo snap install clion --classic
sudo snap install pycharm-professional --classic
sudo snap install datagrip --classic
sudo snap install mailspring --classic
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
nvim +PluginInstall +qall
```
