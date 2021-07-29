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

plugins=(fzf ssh-agent git fast-syntax-highlighting zsh-autosuggestions colored-man-pages)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='vim'
else
export EDITOR='vim'
fi

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

alias dropbox="~/.dropbox-dist/dropboxd"
alias vrc="vim $HOME/.vimrc"
alias zrc="vim $HOME/.zshrc"
alias py='python'
# alias rm='rm -i'
alias gpu='watch nvidia-smi'
alias src='source'

# alias gvim='gvim -p --remote-tab-silent'
alias wiki='vim $HOME/vimwiki/index.wiki'
alias nu='vim ~/.newsboat/urls'
alias nc='vim ~/.newsboat/config'
alias cheat='~/bin/cheat-linux-amd64'
alias cfg='cd $HOME/.config; ls'
alias jl='jupyter-lab'


# alias ..='cd .. ; colorls -a'
# alias ...='cd ../../ ; colorls -a'
alias ls='colorls'

# # cd-ls alias
# function chpwd() {
    # emulate -L zsh
    # ls -a
# }

# Open files in default programs (without specifying the name)
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

# Dynamically set alias to cd in directory
cdalias () {
  if [ $# -ne 1 ]; then
    echo "Input alias name to cd in the current directory"
    return 1
  fi

  if alias $1 2>/dev/null; then
    echo "alias '$1' already exists! Use another name."
  else
    echo "alias $1='cd $PWD'" >> $HOME/.oh-my-zsh/custom/custom_alias.zsh
    echo "Created alias '$1'. Restart terminal for the changes to take effect."
  fi

}


# vim
type vim &>/dev/null && {
  alias vi='vim'
  alias vii='vim --noplugin'
  alias viii='vim -u NONE'
}

pdf2image () {
  if [ $# -ne 2 ]; then
    echo "Usage: pdf2png INPUT_FILE OUTPUT_FILE"
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

# added by Anaconda3 5.3.0 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
_conda_setup="$(CONDA_REPORT_ERRORS=false '$HOME/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

source $HOME/.config/broot/launcher/bash/br
eval "$(mcfly init zsh)"
