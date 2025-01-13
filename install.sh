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

# Add packagecloud to install git-lfs
curl https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash -

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
    zlib1g-dev \
    git-lfs \
    pipx \
    fd-find

# Install Node v21
curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# Install nerd font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/DejaVuSansMono.zip
unzip DejaVuSansMono.zip -d ~/.fonts
fc-cache -fv

# Install zsh and make it the default shell
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
chsh -s /bin/zsh

# Setup a debugpy virtualenv
mkdir ~/.virtualenvs
python3 -m venv ~/.virtualenvs/debugpy
source ~/.virtualenvs/debugpy/bin/activate && pip3 install debugpy && deactivate

# Install thefuck
pip3 install thefuck shell-gpt --user
