version=${1:-'simple'}

ln -nsf ~/dotfiles/.bashrc ~/.bashrc
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

mkdir -p ~/.config/nvim
echo 'set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc' > ~/.config/nvim/init.vim

if [ "$version" == "full" ]; then
    ln -nsf ~/dotfiles/vim/full.vim ~/.vimrc

    # Install Plug (Vim plugin manager).
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # Install FZF (fuzzy finder on the terminal and used by a Vim plugin).
    rm -rf ~/.fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

    pip3 install pynvim jedi
else
    ln -nsf ~/dotfiles/vim/simple.vim ~/.vimrc
fi
