#! /bin/bash


if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v wget &> /dev/null; then
    echo -e "ZSH and Git are already installed\n"
else
    if sudo apt install -y zsh git wget  || sudo pacman -S zsh git wget || sudo dnf install -y zsh git wget || sudo yum install -y zsh git wget || sudo brew install git zsh wget || pkg install git zsh wget ; then
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
   echo -e "Backed-up \.tmux\.conf to .tmux.conf-backup-date and installing new config\n"
   wget https://raw.githubusercontent.com/MrPandey01/dotfiles/master/.tmux.conf -P $HOME
 else
   wget https://raw.githubusercontent.com/MrPandey01/dotfiles/master/.tmux.conf -P $HOME
fi

echo -e "Configuring exa\n"
if command -v exa &> /dev/null; then
    echo -e "exa are already installed\n"
else
    wget https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip -P ~/.local/share && cd ~/.local/share && unzip -d exa/ exa-linux-x86_64-v0.10.0.zip
    echo 'export PATH=~/.local/share/exa/bin:$PATH' >> ~/.zshrc
    echo -e "exa Installed\n"
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

exit 0
