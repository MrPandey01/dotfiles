# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="af-magic"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(fzf ssh-agent git fast-syntax-highlighting zsh-autosuggestions colored-man-pages zsh-vi-mode)

# Man page completions (with Tab)
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='nvim'
else
export EDITOR='nvim'
fi

# vim
type vim &>/dev/null && {
  alias vi='nvim'
}

# Aliases -----------------
source $HOME/.oh-my-zsh/custom/custom_alias.zsh

# Git aliases
alias gau="git add -u"
alias gcm='f() {git commit -m $1}; f'
alias gfr="git fetch --all && git reset --hard origin/master"
alias gpuom="git push -u origin master"

alias pau="priv_files add -u; echo priv_files add -u"
alias pcm='priv_files commit -m "updates"; echo priv_files committed'
alias ppuom="priv_files push -u origin master; echo priv_files pushed"
alias pfr="priv_files fetch --all && priv_files reset --hard origin/master"

alias dau="dotfiles add -u && echo dotfiles add -u"
alias dcm='f() {dotfiles commit -m $1}; f'
alias dpuom="dotfiles push -u origin master; pau; pcm; ppuom"
alias dfr="dotfiles fetch --all; dotfiles reset --hard origin/master"

alias priv_files='/usr/bin/git --git-dir=$HOME/.priv_files/ --work-tree=$HOME/'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME/'

# Other aliases
alias dropbox="~/.dropbox-dist/dropboxd"
alias zrc="nvim $HOME/.zshrc"
alias py='python3'
alias gpu='watch nvidia-smi'
alias src='source'

alias wiki='nvim $HOME/vimwiki/index.wiki'
alias nu='nvim ~/.newsboat/urls'
alias nc='nvim ~/.newsboat/config'
alias cheat='~/bin/cheat-linux-amd64'
alias jl='jupyter-lab'

# exa settings and aliases
exa_params=('--git' '--icons' '--classify' '--group-directories-first' '--time-style=long-iso' '--group' '--color-scale')

alias ls='exa ${exa_params}'
alias l='exa --git-ignore ${exa_params}'
alias ll='exa --all --header --long ${exa_params}'
alias llm='exa --all --header --long --sort=modified ${exa_params}'
alias la='exa -lbhHigUmuSa'
alias lx='exa -lbhHigUmuSa@'
alias lt='exa --tree --level=2'
alias tree='exa --tree --level=2'

# Open files with default programs (without specifying the name)
# from terminal
function open () {
    xdg-open "$*" &>/dev/null
}

alias -s pdf=open
alias -s png=open
alias -s jpg=open
alias -s jpeg=open
alias -s txt=open
alias -s dat=open
alias -s log=open

# Compressed file expander
# (from https://github.com/myfreeweb/zshuery/blob/master/zshuery.sh)
ex() {
    if [[ -f $1 ]]; then
        case $1 in
          *.tar.bz2) tar xvjf $1;;
          *.tar.gz) tar xvzf $1;;
          *.tar.xz) tar xvJf $1;;
          *.tar.lzma) tar --lzma xvf $1;;
          *.bz2) bunzip $1;;
          *.rar) unrar $1;;
          *.gz) gunzip $1;;
          *.tar) tar xvf $1;;
          *.tbz2) tar xvjf $1;;
          *.tgz) tar xvzf $1;;
          *.zip) unzip -d ${1%.zip} $1;;
          *.Z) uncompress $1;;
          *.7z) 7z x $1;;
          *) echo "'$1' cannot be extracted via >ex<";;
    esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Prepare current latex project for arXiv
arxiv () {
    echo "arxiv_latex $PWD"
    arxiv_latex $PWD
    app="_arXiv"
    echo "Converting eps to pdf in $PWD$app ..."
    cd $PWD$app
    find . -name "*.eps" -exec epstopdf {} \;
    rm *.eps
    echo "Replacing .eps to .pdf "
    find $PWD -type f -exec sed -i 's/\.eps/\.pdf/g' {} \;
}

pdf2image () {
  if [ $# -ne 2 ]; then
    echo "Usage: pdf2image INPUT_FILE OUTPUT_FILE"
    return 1
  fi
  pdf_file=$1
  out_file=$2
  convert -density 300x300 -quality 95 $pdf_file $out_file
}


# Go back n directories. For ex: ..3, to go up 3 dirs
function .. {
  for i in $(seq 1 $1); do cd ..; done
}

# mkdir and cd
mkcd() { mkdir -p "$@" && cd "$1"; }

# DIRECTORY BOOKMARKS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Src https://pilabor.com/blog/2021/03/unix-shell-tricks/
# choose a directory where bookmarks are stored
FAV_DIR="$HOME/.fav"

# create the directory, if it does not exist
test -d "$FAV_DIR" || mkdir -p "$FAV_DIR"

# make cd lookup bookmark directory by default
export CDPATH=".:$FAV_DIR"

## create a bookmark name for current directory (e.g. favmk @dotfiles) 
function favmk {
  mkdir -p "$FAV_DIR"; 
  [ -d "${FAV_DIR}" ] && (ln -s "$(pwd)" "$FAV_DIR/$1") || (echo "fav directory ${FAV_DIR} could not be created")
}

## remove a bookmark (e.g. favrm @dotfiles)
function favrm {
  rm -i "$FAV_DIR/$1"
}

## goto bookmark or list existing bookmarks (e.g. fav or fav @dotfiles)
function fav {
  if [ ! -z "$1" ]; then
    [ -e "$FAV_DIR/$1" ] && cd -P "$FAV_DIR/$1" && return 0

    echo "Supported functions: favmk @<name>, favrm @<name>"
    echo "No such fav: $1"
    echo "Would you like to create one? [y/N]"
    read RESPONSE
    if [ "$RESPONSE" = "y" ]; then
      favmk "$1"
    fi
  fi

  ls -l "$FAV_DIR" | sed 's/  / /g' | cut -d' ' -f9-
}
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


# sanitize pdf of its metadata
# clean_pdf() {
 # pdftk $1 dump_data | \
  # sed -e 's/\(InfoValue:\)\s.*/\1\ /g' | \
  # pdftk $1 update_info - output clean-$1
#
 # exiftool -all:all= clean-$1
 # exiftool -all:all clean-$1
 # exiftool -extractEmbedded -all:all clean-$1
 # qpdf --linearize clean-$1 clean2-$1
#
 # pdftk clean2-$1 dump_data
 # exiftool clean2-$1
 # pdfinfo -meta clean2-$1
# }

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

source $HOME/.config/broot/launcher/bash/br
eval "$(mcfly init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# nala zsh completions
autoload bashcompinit
bashcompinit
source /usr/share/bash-completion/completions/nala

fpath+=${ZDOTDIR:-~}/.zsh_functions
fpath+=${ZDOTDIR:-~}/.zsh_functions
