ln -s .bashrc ~/.bashrc
ln -s .vimrc ~/.vimrc

sudo apt-get update && sudo apt-get install -y \
    curl \
    git \
    gpg \
    htop \
    python3-pip \
    rsync \
    tmux \
    unzip

sudo add-apt-repository ppa:neovim-ppa/stable 
sudo apt-get update
sudo apt-get install neovim

source ~/.bashrc
source ~/.vimrc


