version=${1:-'simple'}
latex=${2:-'no'}

ln -nsf ~/dotfiles/.bashrc ~/.bashrc
sudo apt-get update && sudo apt-get install -y \
    curl \
    git \
    gpg \
    htop \
    python3-pip \
    rsync \
    tmux \
    unzip \
    virtualenv

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
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update && sudo apt install yarn

    if [ "$latex" == 'yes' ]; then
        echo 'source ~/dotfiles/vim/latex.vim' >> ~/.vimrc

        # Install tex live
        echo "Installing TeX Live. This can take an hour."
        curl https://mirror.aarnet.edu.au/pub/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz --output install-tl-unx.tar.gz
        tar -xvzf install-tl-unx.tar.gz
        cd *install-tl* && sudo perl install-tl

        echo "Don't forget to set your PATH!"
        echo "Install a PDF reader here: https://medium.com/@Pirmin/a-minimal-latex-setup-on-windows-using-wsl2-and-neovim-51259ff94734"
    fi
fi
