# Make sure directories exist
mkdir -p ~/.config
mkdir -p ~/.local/bin

# Make soft simlinks of rc files to home directory
ln -nsf ~/dotfiles/.zshrc ~/.zshrc
ln -nsf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -nsf ~/dotfiles/.gitconfig ~/.gitconfig
ln -nsf ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/scripts/* ~/.local/bin/

# Copy a template of .env file to the home directory
cp ~/dotfiles/.env.template ~/.env

# Use latest neovim versions
sudo add-apt-repository ppa:neovim-ppa/unstable

# Install dependencies
sudo apt update && sudo apt install -y \
    curl \
    gnupg \
    git \
    htop \
    rsync \
    tmux \
    unzip \
    neovim \
    zsh \
    ripgrep \
    python3-pip \
    zplug \
    fontconfig \
    nodejs \
    ruby-full \
    build-essential \
    zlib1g-dev

# Install Node v20
sudo mkdir -p /etc/apt-keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt update && sudo apt install -y \
    nodejs \
    npm

# Install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# Install nerd font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/DejaVuSansMono.zip
unzip DejaVuSansMono.zip -d ~/.fonts
fc-cache -fv

# Setup packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install zsh and make it the default shell
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
chsh -s /bin/zsh

# Install thefuck
pip3 install thefuck shell-gpt --user

# Install jekyll and bundler for blog
gem install jekyll bundler
