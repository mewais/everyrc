#!/bin/bash

# Install brave browser
sudo apt install apt-transport-https curl 
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt upgrade
sudo apt install brave-browser

# Install dev tools
sudo apt install wget build-essential git cmake python3-pip gettext libgettextpo-dev
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm -rf lazygit lazygit.tar.gz

# Nerd Fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/Meslo.zip
unzip Meslo.zip -d ~/.fonts
fc-cache -fv
rm Meslo.zip

# Build neovim from source, Ubuntu has an old version if you install
git clone https://github.com/neovim/neovim
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install
cd ../ && rm neovim -rf

# Install nvim plugin requirements
sudo apt install ccls python3-venv
sudo npm i -g bash-language-server
sudo pip3 install cmake-language-server hdl-checker pyright --upgrade

# Copy nvim config and install plugins
cp nvim/init.lua ~/.config/nvim/init.lua
cp nvim/lua/ ~/.config/nvim/lua/ -r

# Install zsh, lsd, bashtop, and bat 
sudo add-apt-repository ppa:bashtop-monitor/bashtop
sudo apt update
sudo apt install bat zsh bashtop
wget -c https://github.com/lsd-rs/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb
sudo dpkg -i lsd_0.23.1_amd64.deb
rm lsd_0.23.1_amd64.deb

# Copy zsh config
cp zsh/zshrc ~/.zshrc
mkdir ~/.zsh
cp zsh/p10k.zsh ~/.zsh/p10k.zsh

# Use zsh by default
chsh -s $(which zsh)

# Pimp my terminal
bash -c "$(curl -sLo- https://git.io/vQgMr)"
# Pick a theme, reminder, I like 08
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

# Move the ssh config
cp ssh/config ~/.ssh/config
