version=${1:-'simple'}

ln -nsf ~/dotfiles/.bashrc ~/.bashrc
ln -nsf ~/dotfiles/.tmux.conf ~/.tmux.conf
sudo pacman -Syu && sudo pacman -S --needed \
    curl \
    git \
    gnupg \
    htop \
    rsync \
    tmux \
    unzip \
    ripgrep \
    the_silver_searcher \
    neovim \
    nodejs \
    npm

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

    # Install yarn
    sudo npm install --global yarn

    # Install vim extensions
    nvim --headless +PlugInstall +qall
fi
