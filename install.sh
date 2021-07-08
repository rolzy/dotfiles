version=${1:-'simple'}

ln -nsf ~/dotfiles/.bashrc ~/.bashrc
ln -nsf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -nsf ~/dotfiles/.gitconfig ~/.gitconfig

sudo apt-get update && sudo apt-get install -y \
    curl \
    git \
    gpg \
    htop \
    python3-pip \
    rsync \
    tmux \
    unzip \
    ripgrep \
    virtualenv \
    silversearcher-ag

sudo add-apt-repository ppa:neovim-ppa/stable 
sudo apt-get update
sudo apt-get install neovim

mkdir -p ~/.config/nvim
echo 'set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc' > ~/.config/nvim/init.vim

echo 'source ~/dotfiles/vim/simple.vim' > ~/.vimrc

if [ "$version" == "full" ]; then
    echo 'source ~/dotfiles/vim/full.vim' >> ~/.vimrc

    # Install Plug (Vim plugin manager).
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # Install FZF (fuzzy finder on the terminal and used by a Vim plugin).
    rm -rf ~/.fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

    # Install nodejs/yarn
    curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
    sudo bash nodesource_setup.sh
    sudo apt install nodejs

    # Install yarn
    sudo npm i -g yarn pyright bash-language-server

    # Install vim extensions
    nvim --headless +PlugInstall +qall
    nvim --headless +'TSInstall python bash' +qall
fi
