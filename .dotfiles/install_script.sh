#! /bin/bash


if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v wget &> /dev/null; then
    echo -e "ZSH and Git are already installed\n"
else
    if sudo apt install -y zsh git wget || sudo pacman -S zsh git wget || sudo dnf install -y zsh git wget || sudo yum install -y zsh git wget || sudo brew install git zsh wget || pkg install git zsh wget ; then
        echo -e "zsh wget and git Installed\n"
    else
        echo -e "Please install the following packages first, then try again: zsh git wget \n" && exit
    fi
fi


if mv -n ~/.zshrc ~/.zshrc-backup-$(date +"%Y-%m-%d"); then # backup .zshrc
    echo -e "Backed up the current .zshrc to .zshrc-backup-date\n"
fi

echo -e "Configuring .zshrc\n"
if [ -d ~/.zsh-plugins ]; then
    echo -e "zsh is already configured\n"
else
    wget https://raw.githubusercontent.com/MrPandey01/dotfiles/master/.zshrc -P $HOME
fi

echo -e "Configuring tmux\n"
if [ -f ~/.tmux.conf ]; then
   mv -n ~/.tmux.conf ~/.tmux.conf-backup-$(date +"%Y-%m-%d")
   echo -e " Backed-up \.tmux\.conf to .tmux.conf-backup-date\n"
else
    wget https://raw.githubusercontent.com/MrPandey01/dotfiles/master/.tmux.conf -P $HOME
fi


# INSTALL FONTS
echo -e "Installing Nerd Fonts SauceCodePro\n"
if [ -f "~/.local/share/fonts/Sauce Code Pro Nerd Font Complete.ttf" ]; then
    echo -e "NerdFont already exist\n"
else
    wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip -P ~/.local/share/fonts/

    cd ~/.local/share/fonts/ && unzip SourceCodePro.zip

    rm -f SourceCodePro.zip && cd -
fi

fc-cache -fv ~/.local/share/fonts

echo -e "Configuring fzf\n"
if [ -d ~/.fzf ]; then
    echo -e "\.fzf is already exist\n"
else
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all --key-bindings --completion --update-rc
fi

exit 0
