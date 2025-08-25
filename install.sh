# Make sure directories exist
mkdir -p ~/.config
mkdir -p ~/.local/bin
mkdir -p ~/projects
mkdir -p ~/projects/oss

# Make soft simlinks of rc files to home directory
ln -nsf ~/dotfiles/.zshrc ~/.zshrc
ln -nsf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -nsf ~/dotfiles/.gitconfig ~/.gitconfig
ln -nsf ~/dotfiles/nvim ~/.config/nvim
ln -nsf ~/dotfiles/amazonq/mcp.json ~/.aws/amazonq/mcp.json
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
	ruby-full \
	build-essential \
	zlib1g-dev \
	git-lfs \
	pipx \
	fd-find \
	wslu

# Install uv
pipx install uv

# Install Node v21
curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# Install zsh and make it the default shell
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
chsh -s /bin/zsh

## Setup a debugpy virtualenv
#mkdir ~/.virtualenvs
#python3 -m venv ~/.virtualenvs/debugpy
#source ~/.virtualenvs/debugpy/bin/activate && pip3 install debugpy && deactivate

# Install thefuck
pipx install thefuck shell-gpt

# Install cfn-lsp-extra
git clone https://github.com/rolzy/cfn-lsp-extra.git ~/projects/oss/cfn-lsp-extra
uv tool install ~/projects/oss/cfn-lsp-extra

# Install the AWS CLI and add-ons
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
sudo dpkg -i session-manager-plugin.deb
