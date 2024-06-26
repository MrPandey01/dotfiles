# Znap (Plugin Manager) bootstrap -------------------------
if [ ! -f ~/.zsh-plugins/zsh-snap/znap.zsh ]; then
    mkdir ~/.zsh-plugins/zsh-snap;
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.zsh-plugins/zsh-snap
fi
source ~/.zsh-plugins/zsh-snap/znap.zsh  # Start Znap


# nvim bootstrap -----------------------------------------
nvim_download () {
if [ ! -f $HOME/nvim-linux64/bin/nvim ]; then 
    wget --quiet https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz -P $HOME/ \
    && cd $HOME/ \
    && tar xf nvim-linux64.tar.gz \
    && rm nvim-linux64.tar.gz
fi
}
nvim_download > /dev/null 2>&1 &  # asynchronous
disown >/dev/null 2>&1


# fzf bootstrap -----------------------------------------
fzf_download () {
if [ ! -d $HOME/.fzf/ ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
    && $HOME/.fzf/install
fi
source ~/.fzf.zsh
}
fzf_download > /dev/null 2>&1 &  # asynchronous
disown >/dev/null 2>&1


# Machine Specific Settings -----------------------------------------
if [ ! -f ~/.machine_specific.zsh ]; then
  touch ~/.machine_specific.zsh
fi
source ~/.machine_specific.zsh


# Plugins ---------------------------------------------------------
# `znap prompt` makes your prompt visible in just 15-40ms!
znap prompt sindresorhus/pure  # vi-mode is default with this 

# `znap source` automatically downloads and starts your plugins.
znap source ohmyzsh/ohmyzsh lib/{git,theme-and-appearance}
znap source ohmyzsh/ohmyzsh plugins/{git,ssh-agent,colored-man-pages,fzf,z}
znap source marlonrichert/zsh-autocomplete

ZSH_AUTOSUGGEST_STRATEGY=( history completion )
znap source zsh-users/zsh-autosuggestions

ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets )
znap source zdharma-continuum/fast-syntax-highlighting


# ZSH Settings --------------------------------------------------------
# the detailed meaning of the below three variable can be found in `man zshparam`.
CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Completion suggestions from man pages (using Tab)
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

export HISTFILE=~/.zsh_history
export HISTSIZE=1000000   # the number of items for the internal history list
export SAVEHIST=1000000   # maximum number of items for the history file

# The meaning of these options can be found in man page of `zshoptions`.
setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY  # record command start time

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

# Git aliases
alias gau="git add -u"
alias gcm='f() {git commit -m $1}; f'
alias gfr="git fetch --all && git reset --hard origin/main"
alias gpuom="git push -u origin master"

alias pau="priv_files add -u; echo priv_files add -u"
alias pcm='priv_files commit -m "updates"; echo priv_files committed'
alias ppuom="priv_files push -u origin master; echo priv_files pushed"
alias pfr="priv_files fetch --all && priv_files reset --hard origin/master"

alias dau="dotfiles add -u && echo dotfiles add -u"
alias dcm='f() {dotfiles commit -m $1}; f'
alias dpuom="dotfiles push -u origin master; pau; pcm; ppuom"
alias dfr="dotfiles fetch --all; dotfiles reset --hard origin/main"

alias priv_files='/usr/bin/git --git-dir=$HOME/.priv_files/ --work-tree=$HOME/'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME/'

# Other aliases
alias dropbox="$HOME/.dropbox-dist/dropboxd"
alias zrc="nvim $HOME/.zshrc"
alias py='python3'
alias gpu='watch nvidia-smi'
alias src='source'

alias nv='nvim'

# Tmux
# alias tmux='TERM=screen-256color-bce tmux'
alias tl='tmux list-sessions'
alias ta='tmux attach'

alias jl='jupyter-lab'
alias ipy="ipython --matplotlib --no-banner \
  --TerminalInteractiveShell.editing_mode=vi \
  --TerminalInteractiveShell.autoindent=false \
  --InteractiveShellApp.extensions 'autoreload' \
  --InteractiveShellApp.exec_lines '%autoreload 2' \
  --InteractiveShellApp.exec_lines '%colors Linux' \
  --InteractiveShellApp.exec_lines 'import os,sys' \
  --InteractiveShellApp.exec_lines 'import numpy as np' "

# exa settings and aliases
exa_download () {
if exa ; then
  echo " "
else
    wget https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip -P $HOME/.local/share \
    && cd $HOME/.local/share \
    && unzip -d exa/ exa-linux-x86_64-v0.10.0.zip
    echo 'export PATH=$HOME/.local/share/exa/bin:$PATH' >> $HOME/.machine_specific.zsh
    echo -e "exa Installed\n"
fi
}
exa_download > /dev/null 2>&1 & # asynchronous
disown >/dev/null 2>&1
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

fpath+=${ZDOTDIR:-~}/.zsh_functions
fpath+=~/.zfunc
autoload -Uz compinit && compinit

export PYTHONBREAKPOINT="pudb.set_trace"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('~/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "~/miniconda3/etc/profile.d/conda.sh" ]; then
        . "~/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="~/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

