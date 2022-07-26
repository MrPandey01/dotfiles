# Dotfiles

The dotfiles in this repository are installed using a **bare Git repository**. 
This method does not use symlinks (unlike most other dotfile repositories).

After the installation, all the dotfiles will be saved at exact location as in this repository with ~/ as the root folder.

## First Time Setup

Create a bare repository with an appropriate name. I follow the convention `.dotfiles`.

```
mkdir $HOME/.dotfiles
git init --bare $HOME/.dotfiles
```

Now we create an alias `dotfiles` for running git commands in our `.dotfiles` repository. Add this alias to your `.bashrc` or `.zshrc`. Nice part is that now we can run this command from anywhere.

```
alias dotfiles='$(which git) --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Now we add a remote. Remember to change the following url to point your git repo.

```
dotfiles remote add origin git@github.com:MrPandey01/dotfiles.git
```

Also set the status to not show untracked files whenever we run `dotfiles status` command.

```
dotfiles config --local status.showUntrackedFiles no
```

That's all! Now you can use `dotfiles` command as a replacement of the usual `git` command to add, commit and push dotfiles. For instance

```
dotfiles add ~/.tmux.conf ~/.zshrc
dotfiles commit -m "add .tmux.conf and .zshrc"
dotfiles push
```

## Setting Up a New Machine

To use the same dotfiles on a new machine, all we need to do is clone this repository and tell git that it is a bare repository. To avoid git clone errors when some default dotfiles are already present, we first clone it into a temporary folder and then locally copy and over-write the existing ones.

```
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/MrPandey01/dotfiles.git tmpdotfiles
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -r tmpdotfiles
```

Done!

